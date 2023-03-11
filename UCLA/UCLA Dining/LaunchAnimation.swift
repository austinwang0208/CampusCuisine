//
//  LaunchAnimation.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/24/22.
//

import SwiftUI
import Foundation
import UIKit

enum APIError: Error {
    case invalidStatusCode
    case invalidResponse
}

//class SessionManager: ObservableObject {
//    var isLoggedIn: Bool = false {
//        didSet {
//            rootId = UUID()
//        }
//    }
//
//    @Published
//    var rootId: UUID = UUID()
//}

struct LaunchAnimation: View {
    @State var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    //for storing API call output
    @State private var result: [String: [String : [String]]]?
    @State private var hours: [String: [String : [[Float]]]]?
    @State private var images_loaded: Bool = false
    
    //for knowing which school we need to call api for
    var selectedKey : String
    
//    //for fixing back button issue after new uni is selected
//    @ObservedObject
//    private var sessionManager = SessionManager()
    
    var body: some View {
        if result != nil && isActive && images_loaded {
            ContentView(APIoutput : result!,
                        hours : hours!,
                        output: getFixedMenus(selectedKey: selectedKey),
                        selectedKey: selectedKey
            )
        }
        else {
            ZStack {
                Color(.black)
                    .ignoresSafeArea(.all)
                VStack{
                    VStack{
                        Image(selectedKey + " designer text")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    
                    ProgressBar()
                        .frame(height: 10)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        withAnimation{
                            self.isActive=true
                        }
                    }
                    
                    makePostRequest { result in
                        switch result {
                        case .success(let dictionary):
                            self.result = dictionary
                            Task{
                                await getImageFromAPI(selectedKey: selectedKey, result: self.result, output: getFixedMenus(selectedKey: selectedKey))

                            }
                        case .failure(let error):
                            print(error)
                        }
                    }
                    
                    getHours { hours in
                        switch hours {
                        case .success(let dictionary):
                            self.hours = dictionary
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }

    }
    func getImageFromAPI(selectedKey: String, result: [String:[String: [String]]]?, output: [Hall]) async {
        
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let directory2 = directory?.appendingPathComponent("\(selectedKey)/")
        do{
            try FileManager.default.createDirectory(at: directory2!, withIntermediateDirectories: false)
        } catch let error {
            print("could not create directory", error)
        }
        if let unwrapped = result {
            for key in unwrapped.keys {
                let newkey = key.replacingOccurrences(of: " ", with: "_")
                let path = directory2?.appendingPathComponent("\(newkey).jpg")
                // + "/" + "\(newkey).jpg"
                if checkIfFileExists(selectedKey: selectedKey, key: newkey, path: path) != true{
                    let complete_api = "https:// REMOVED.execute-api.us-west-1.amazonaws.com/v1test/s3?key=" + selectedKey + "/" + "\(newkey).jpg"
                    
                    let url = URL(string: complete_api)!
                    
                    let image = try? await downloadWithAsync(url: url)
                    
                    
                    guard
                        let data = image?.jpegData(compressionQuality: 1.0) else {
                        return
                    }
                    
                    do {
                        try data.write(to: path!)
                    } catch let error{
                        print("error saving \(error)")
                    }
                }
            }
            
            for key in output {
                let newkey = key.name.replacingOccurrences(of: " ", with: "_")
                let path = directory2?.appendingPathComponent("\(newkey).jpg")
                // + "/" + "\(newkey).jpg"
                if checkIfFileExists(selectedKey: selectedKey, key: newkey, path: path) != true{
                    let complete_api = "https:// REMOVED.execute-api.us-west-1.amazonaws.com/v1test/s3?key=" + selectedKey + "/" + "\(newkey).jpg"
                    let url = URL(string: complete_api)!
                    
                    //request.httpMethod = "GET"
                    //request.addValue("image/jpeg", forHTTPHeaderField: "Content-Type")
                    
                    let image = try? await downloadWithAsync(url: url)
                    
                    guard
                        let data = image?.jpegData(compressionQuality: 1.0) else {
                        return
                    }
                    
                    do {
                        try data.write(to: path!)
                    } catch let error{
                        print("error saving \(error)")
                    }
                }
                
                for i in 1...key.sections!{
                    let pdfpath = directory2?.appendingPathComponent("\(newkey)_Menu_\(i).pdf")
                    if checkIfFileExists(selectedKey: selectedKey, key: newkey, path: pdfpath) != true{
                        let complete_api = "https:// REMOVED.execute-api.us-west-1.amazonaws.com/v1test/s3?key=" + selectedKey + "/" + "\(newkey)_Menu_\(i).pdf"
                        let pdfFile = try? Data.init(contentsOf: URL(string: complete_api)!)

                        do {
                            try pdfFile?.write(to: pdfpath!, options: .atomic)
                        } catch {
                            print("error saving pdf")
                        }
                        
                        
                    }
                    
                }
                
            }
            images_loaded = true        }
    }
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard let data = data,
              let image = UIImage(data: data),
              let response = response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
                return nil
        }
        return image
                
    }

    func downloadWithAsync(url: URL) async throws -> UIImage? {
        do {
            let (data, response) = try await URLSession.shared.data(from: url, delegate: nil)
            return handleResponse(data: data, response: response)
        } catch {
            throw error
        }
    }
    
    func checkIfFileExists(selectedKey: String, key: String, path:URL?) -> Bool {
        if let path = path {
            if FileManager.default.fileExists(atPath: path.path){
                return true
            }else {
                return false
            }
        }
        return false
    }
    
    func makePostRequest(completion: @escaping (Result<[String: [String : [String]]], Error>) -> Void) {
            let complete_api = "https://49jmxvbvc9.execute-api.us-west-1.amazonaws.com/v2/" + selectedKey
            let url = URL(string: complete_api)!

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            //let parameters = ["key": "value"]
            //request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                if let data = data, let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        
                        do {
                            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                            guard let dictionary = jsonObject as? [String: Any] else {
                                
                                completion(.failure(APIError.invalidResponse))
                                return
                            }
                            var result: [String: [String : [String]]] = [:]
                            for (key, value) in dictionary {
                                //alter code here to make output for dict of dicts
                                if let array = value as? [String : [String]] {
                                    result[key] = array
                                } else {
                                    completion(.failure(APIError.invalidResponse))
                                    return
                                }
                            }

                            completion(.success(result))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(APIError.invalidStatusCode))
                    }
                }
            }
            task.resume()
        }
    
    func getHours(completion: @escaping (Result<[String: [String : [[Float]]]], Error>) -> Void) {
        let complete_api = "https:// REMOVED.execute-api.us-west-1.amazonaws.com/v1test/s3?key=" + selectedKey + "/hours.json"
        let url = URL(string: complete_api)!

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        //let parameters = ["key": "value"]
        //request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
                        guard let dictionary = jsonObject as? [String: [String: [[Float]]]] else {
                            completion(.failure(APIError.invalidResponse))
                            return
                        }
                        
                        var result: [String: [String : [[Float]]]] = [:]
                        for (key, value) in dictionary {
                            //alter code here to make output for dict of dicts
                            let arr = value as?[String : [[Float]]]
                            result[key] = arr
                        }

                        completion(.success(result))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(APIError.invalidStatusCode))
                }
            }
        }
        task.resume()
    }

}

struct LaunchAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LaunchAnimation(selectedKey: "diningmenus")
    }
}
