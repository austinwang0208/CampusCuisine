//
//  ContentView.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/15/22.
//

import SwiftUI

enum APIError: Error {
    case invalidStatusCode
    case invalidResponse
}

struct ContentView: View {
    @State private var result: [String: [String]]?
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    LinearGradient(gradient: Gradient(colors:[Color("TopBackground"),.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        //UCLA Dining Hall text
                        HStack {
                            Text("UCLA Dining Halls")
                                .font(.system(size:28, weight: .medium, design: .default))
                                .foregroundColor(.white)
                                .frame(alignment: .center)
                        }.padding([.top],40)
            
                        
                        //Dining Hall buttons
                        HStack{
                            VStack{
                                //Epicuria and De Neve Dining icons
                                Spacer()

                                let EpicuriaData = Hall(
                                        name: "Epicuria at Covel",
                                        image: "Epicuria at Covel"
                                )
                                
                                NavigationLink(
                                    destination: Menu(hall: EpicuriaData),
                                    label: {
                                        FoodIcon(hall: EpicuriaData)
                                    })
                                
                                Spacer()
                                    
                                
                                let DeNeveData = Hall(
                                        name: "De Neve",
                                        image: "De Neve Dining"
                                )
                                NavigationLink(
                                    destination: Menu(hall: DeNeveData),
                                    label: {
                                        FoodIcon(hall: DeNeveData)
                                    })
                                    
                                Spacer()
                        
                                //Bruin Plate icon
                                let BruinPlateData = Hall(
                                        name: "Bruin Plate",
                                        image: "Bruin Plate Dining"
                                )
                                NavigationLink(
                                    destination: Menu(hall: BruinPlateData),
                                    label: {
                                        FoodIcon(hall: BruinPlateData)
                                    })
                            }
                        }//.padding([.bottom], 30)
                        
                        //Restaurant Buttons + text
                        HStack{
                            VStack{
                                
                                //Restaurant text
                                HStack {
                                    Text("Quick Service Restaurants")
                                        .font(.system(size:28, weight: .medium, design: .default))
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                
                                //restaurant icons
                                VStack{
                                    Spacer()
                                    
                                    HStack{
                                        Spacer()
                                        
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("Epicuria at Ackerman")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        
                                        Spacer()
                                        
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("the drey")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        
                                        Spacer()
                                    }
                                    
                                    Spacer()
                                    
                                    HStack{
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("Bruin Bowl")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("Rendezvous")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("Bruin Cafe")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("Cafe 1919")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                    }
                                    Spacer()
                                    HStack{
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("De Neve Late Night")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                        NavigationLink(
                                            destination: Text("menu"),
                                            label: {
                                                HStack{
                                                    Image("The Study at Hedrick")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: 150)
                                                }
                                            })
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
    
    func makePostRequest(completion: @escaping (Result<[String: [String]], Error>) -> Void) {
        let url = URL(string: "https://i5bka3jah1.execute-api.us-west-1.amazonaws.com/prod")!

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["key": "value"]
        request.httpBody = try! JSONSerialization.data(withJSONObject: parameters)

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

                        var result: [String: [String]] = [:]
                        for (key, value) in dictionary {
                            if let array = value as? [String] {
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
