//
//  LaunchAnimation.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/24/22.
//

import SwiftUI

enum APIError: Error {
    case invalidStatusCode
    case invalidResponse
}

struct LaunchAnimation: View {
    @State var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    //for storing API call output
    @State private var result: [String: [String : [String]]]?
    
    //for knowing which school we need to call api for
    var selectedKey : String
    
    var body: some View {
        if result != nil && isActive {
            ContentView(APIoutput : result!,
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
                        case .failure(let error):
                            print(error)
                        }
                    }
                }
            }
        }
    }
    
    func makePostRequest(completion: @escaping (Result<[String: [String : [String]]], Error>) -> Void) {
        print("calling API..." + selectedKey)
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

}

struct LaunchAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LaunchAnimation(selectedKey: "diningmenus")
    }
}
