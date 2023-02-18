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
    let x = ["diningmenus": "UCLA Dining", "ucbdiningmenus": "UCB Dining", "ucddiningmenus": "UCD Dining", "ucidiningmenus": "UCI Dining", "ucmdiningmenus": "UCM Dining", "ucrdiningmenus": "UCR Dining", "ucsbdiningmenus": "UCSB Dining", "ucscdiningmenus":"UCSC Dining", "ucsddiningmenus":"UCSD Dining"]

    
    //    passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    var output : [Hall]
    var selectedKey : String
    @State private var searchText = ""
    @State private var showResults = false
//    @StateObject var oo = SearchObservableObject()
    
    // to keep track of navigation path
    //@State private var path: [String]
    
    var body: some View {
        let NoData = ["No Data displayed" : ["Nothing to show"]]
        NavigationView {
            VStack {
                HStack {
                    TextField("Search", text: $searchText) { isEditing in
                        self.showResults = true
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                    .onTapGesture {
                        self.showResults = true
                    }
                    if showResults {
                        Button("Cancel") {
                            self.searchText = ""
                            self.showResults = false
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        .padding(.trailing, 8)
                    }
                }
                if showResults {
                    SearchResultView(APIoutput: APIoutput, searchText: searchText, selectedKey: selectedKey)
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
            .navigationTitle(x[selectedKey]!)
            .preferredColorScheme(.light)
            .tint(.black)
        }
    }
}

struct SearchResultView: View {
    var APIoutput : [String: [String : [String] ]]
    let searchText: String
    var selectedKey : String
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
        let hallNames = Array(APIoutput.keys).sorted {$0 < $1}
        let res = Dictionary(uniqueKeysWithValues:
                                hallNames.map { name in
            (name, Hall(selectedKey: selectedKey, name: name, dishes: APIoutput[name] ?? NoData))
        }
        )
        
        let searchData = getData().filter { $0.food.contains(searchText) }
        ScrollView{
            ForEach(searchData, id: \.id) { itemData in
                NavigationLink(destination: Menu(hall: res[itemData.hallname]!)){
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
                .buttonStyle(PlainButtonStyle())
                .padding(.vertical,4)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
}
//        ScrollView{
//
//            ForEach(searchData, id: \.id) { itemData in
//                HStack {
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text (itemData.food)
//                            .font(.title2.weight(.semibold))
//                        Group{
//                            Text (itemData.mealtime)
//                            Text (itemData.hallname)
//                        }
//                        .foregroundColor(.gray)
//                    }
//                }.padding(.vertical,4)
//            }
//        }
//            }
//        }

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
    
    
    

