//
//  ContentView.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/15/22.
//

import SwiftUI
import GoogleMobileAds

struct ContentView: View {
    //dictionary for converting selectedKey into university acronyms
    let x = ["diningmenus": "UCLA Dining", "ucbdiningmenus": "UCB Dining", "ucddiningmenus": "UCD Dining", "ucidiningmenus": "UCI Dining", "ucmdiningmenus": "UCM Dining", "ucrdiningmenus": "UCR Dining", "ucsbdiningmenus": "UCSB Dining", "ucscdiningmenus":"UCSC Dining", "ucsddiningmenus":"UCSD Dining"]

    
    //    passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    var output : [Hall]
    var selectedKey : String
    @State private var searchText = ""
    
    var body: some View {
        let NoData = ["No Data displayed" : ["Nothing to show"]]
//        let titleView = HStack {
//                    Image(selectedKey + " designer text")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(height: 40)
//                    Text("Dining")
//                        .font(.system(size: 32))
//                        .foregroundColor(.black)
//                        .fontWeight(.semibold)
//                }
//                    .frame(maxWidth: .infinity)
//                .background(Color("NavBar color"))
//                .edgesIgnoringSafeArea(.horizontal)
        NavigationStack{
            
            VStack {
                Section(footer: FooterView()){
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
                                .padding()
                                HStack {
                                    Text("Quick Service Restaurants")
                                        .font(.system(size:28, weight: .medium, design: .default))
                                        .foregroundColor(.black)
                                }
                                VStack{
                                    let sortedOutput = output.sorted { $0.name < $1.name }
                                    ForEach(sortedOutput, id: \.self) { hall in
                                        NavigationLink(destination: fixed_menu(hall: hall), label: {
                                            FoodIcon(hall: hall)
                                        })
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(x[selectedKey]!)
//            .navigationBarTitle("", displayMode: .inline)
//                            .toolbarBackground(
//                                Color("NavBar color"),
//                                for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//            .navigationBarItems(
//                    leading:
//                        HStack {
//                            titleView
//                        }
//                            )
      .searchable(text: $searchText, prompt: "Search Dining Halls")
        }
        .tint(.black)
    }
    
    
    
    
    struct ContentView_Previews: PreviewProvider {
        static let APIpreview = ["Epicuria at Covel" :["Breakfast" : ["eggs", "bacon", "cheese"],"Lunch" : ["sandwhich", "burgers", "fries"],"Dinner" : ["nachos", "pasta", "soda"]],"De Neve" :
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
    
    
    
}
