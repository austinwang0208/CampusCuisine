//
//  ContentView.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/15/22.
//

import SwiftUI
import SwiftUIX
import GoogleMobileAds

struct ContentView: View {
    
    //dictionary for converting selectedKey into university acronyms
    let x = ["diningmenus": "UCLA Dining", "ucbdiningmenus": "UCB Dining", "ucddiningmenus": "UCD Dining", "ucidiningmenus": "UCI Dining", "ucmdiningmenus": "UCM Dining", "ucrdiningmenus": "UCR Dining", "ucsbdiningmenus": "UCSB Dining", "ucscdiningmenus":"UCSC Dining", "utaustindiningmenus":"UTAustin Dining"]

    
    //    passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    var output : [Hall]
    var selectedKey : String
    @State private var searchText = ""
    @State private var showResults = false
//    @StateObject var oo = SearchObservableObject()
    
    
//    let attrs = [
//        NSAttributedString.Key.foregroundColor: UIColor.white,
//    ]

    
    // to keep track of navigation path
    //@State private var path: [String]
    var body: some View {
        NavigationView {
            
            SearchingView(searchText: $searchText, APIoutput: APIoutput, selectedKey: selectedKey, output: output)
                .searchable(text: $searchText, prompt: "Search food")
            //add , placement: .navigationBarDrawer(displayMode: .always) to make search bar always stay
                .autocorrectionDisabled(true)
                .navigationBarTitle(x[selectedKey]!)
//                .toolbarBackground(
//                    Color("NavBar color"),
//                    for: .tabBar)
//
//                .toolbarBackground(.visible, for: .navigationBar)
                .navigationBarItems(
                    //leading:
                        //VStack{
                            //Text(x[selectedKey]!)
                            //    .font(.custom("SF Pro Display", size: 20))
                            //},
                        trailing:
                            VStack {
                                //Text(" ")
                                //Text(" ")
                                //Text(" ")
                                NavigationLink(destination: SettingsView()) {
                                    Image(systemName: "gear")
                                        .font(.system(size: 16))
                                        .foregroundColor(.black)
                                }
                            }
                )
            
//                .foregroundColor(Color(.white))
                .preferredColorScheme(.light)
                .tint(.black)
            

            
        }.accentColor(.black)
//            .foregroundColor(Color("NavBar color"))
//        .onAppear {
//            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = .white
//            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
//            UINavigationBar.appearance().titleTextAttributes = attrs
            
            
//
//        }
    }
}


struct SearchingView: View {
    @Environment(\.isSearching) private var isSearching
    @Binding var searchText: String
    var APIoutput : [String: [String : [String] ]]
    var selectedKey : String
    var output : [Hall]
    let NoData = ["No Data displayed" : ["Nothing to show"]]
    
    func getData() -> [ItemDataObject] {
        var items = [ItemDataObject]()
        for (hall, meals) in APIoutput {
            for (meal, itemList) in meals {
                for item in itemList {
                    let itemDataObject = ItemDataObject(food: item, mealtime: meal, hallname: hall)
                    items.append(itemDataObject)
                }
            }
        }
        return items
    }
    
    var body: some View {
        if isSearching {
            let hallNames = Array(APIoutput.keys).sorted {$0 < $1}
            let res = Dictionary(uniqueKeysWithValues:
                                    hallNames.map { name in
                (name, Hall(selectedKey: selectedKey, name: name, dishes: APIoutput[name] ?? NoData))
            }
            )
            
            let searchData = getData().filter { $0.food.contains(searchText) }
            ScrollView{
                ForEach(searchData, id: \.id) { itemData in
                    Divider()
                    Button(action: {
                        // Do something here if you need to
                    }) {
                        NavigationLink(destination: Menu(hall: res[itemData.hallname]!)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(itemData.food)
                                    .font(.system(size:17, weight: .medium, design: .default))
                                Group {
                                    Text(itemData.mealtime)
                                    Text(itemData.hallname)
                                }
                                .foregroundColor(.gray)
                                .font(.system(size:15, weight: .medium, design: .default))
                            }
                            .padding(.leading, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.vertical,4)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
                } else {
                    ScrollView {
                        ZStack {
                            VStack {
                                //Dining Hall buttons
                                VStack{
                                    let hallNames = Array(APIoutput.keys).sorted {$0 < $1}
                                    ForEach(hallNames, id: \.self) { name in
                                        let hallData = Hall(selectedKey: selectedKey, name: name, dishes: APIoutput[name] ?? NoData)
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
                                        }
                                        )}}
                            }
                        }
                    }

                }
            }
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
    
    
    

