//
//  ContentView.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/15/22.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    @State private var bannerView: GADBannerView?
    
    //for storing state of search bar
    @State private var searchText = ""
    
    //passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    var output : [Hall]
    var selectedKey : String
    
    var body: some View {

        let NoData = ["No Data displayed" : ["Nothing to show"]]
        let titleView = HStack {
            Image(selectedKey + " designer text")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            Text("Dining")
                .font(.system(size: 32))
                .foregroundColor(.black)
                .fontWeight(.semibold)
        }
            .frame(maxWidth: .infinity)
        .background(Color("NavBar color"))
        .edgesIgnoringSafeArea(.horizontal)
        
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea(.all)
                //v stack with your ucla dining hall text
                VStack {
                    ScrollView {
                        
                        ZStack {
                            
                            VStack {
                                //Dining Hall buttons
                                VStack{
                                    let hallNames = Array(APIoutput.keys).sorted {$0 < $1}
                                    ForEach(hallNames, id: \.self) { name in
                                        let hallData = Hall(name: name, dishes: APIoutput[name] ?? NoData, image: name)
                                        NavigationLink(destination: Menu(hall: hallData)) {
                                            FoodIcon(hall: hallData)
                                        }
                                    }
                                }
                                .padding(.top, 80)
                                
                                //Restaurant text
                                HStack {
                                    Text("Quick Service Restaurants")
                                        .font(.system(size:28, weight: .medium, design: .default))
                                        .foregroundColor(.black)
                                }
                                
                                //Restaurant Buttons
                                VStack{
                                    let sortedOutput = output.sorted { $0.name < $1.name }
                                    ForEach(sortedOutput, id: \.self) { hall in
                                        NavigationLink(destination: fixed_menu(hall: hall), label: {
                                            FoodIcon(hall: hall)
                                        })
                                    }
                                }
                            }
                            .padding()
                        }
                    }.edgesIgnoringSafeArea(.all)
                }
            }.navigationBarTitle("", displayMode: .inline)
                .toolbarBackground(
                    Color("NavBar color"),
                    for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarItems(
                    leading:
                        VStack {
                            titleView
                        },
                    trailing:
                        VStack {
                            NavigationLink(destination: SettingsView()) {
                                Image(systemName: "gear")
                                    .foregroundColor(.black)
                                }
                        //SearchBar(text: $searchText)
                        }
                )
        }.tint(.black)
        .preferredColorScheme(.light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let APIpreview = [
                             "Epicuria at Covel" :
                                [
                                    "Breakfast" : ["eggs", "bacon", "cheese"],
                                    "Lunch" : ["sandwhich", "burgers", "fries"],
                                    "Dinner" : ["nachos", "pasta", "soda"]
                                 ],
                             
                             "De Neve" :
                                [
                                    "Breakfast" : ["cereal", "oatmeal", "eggs"],
                                    "Lunch" : ["Noodles", "Chicken", "Bistro"],
                                    "Dinner" : ["Tenders", "Salad", "Tomatoe Soup"]
                                ],
                             
                             "Bruin Plate" :
                                [
                                    "Breakfast" : ["Bread", "Coffee", "Fruits"],
                                    "Lunch" : ["Falafels", "Pizza", "French Fries"],
                                    "Dinner" : ["Tacos", "Quesadillas", "Chicken Tikka"]
                                ]
                            ]
    
    static var previews: some View {
        // 5. Use the right SecondView initializator
        ContentView(APIoutput: APIpreview,
                    output: getFixedMenus(selectedKey: "diningmenus"),
                    selectedKey: "diningmenus")
    }
}

//SearchBar struct

struct SearchBarForContentView: View {
    @Binding private var searchText : String
    var body: some View {
        HStack {
            TextField("Search", text: $searchText)
                .padding(10)
                .background(Color("searchBarBackground"))
                .cornerRadius(5)
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(10)
        }
    }
}

