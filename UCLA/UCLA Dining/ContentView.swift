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
    let x = ["diningmenus": "UCLA Dining", "ucbdiningmenus": "UCB Dining", "ucddiningmenus": "UCD Dining", "ucidiningmenus": "UCI Dining", "ucmdiningmenus": "UCM Dining", "ucrdiningmenus": "UCR Dining", "ucsbdiningmenus": "UCSB Dining", "ucscdiningmenus":"UCSC Dining", "utaustindiningmenus":"UT Austin Dining"]

    
    //    passed API output and storing in var
    var APIoutput : [String: [String : [String] ]]
    var output : [Hall]
    var selectedKey : String
    @State private var searchText = ""
    @State private var showResults = false
//    @StateObject var oo = SearchObservableObject()
    
    
    let attrs = [
        NSAttributedString.Key.foregroundColor: UIColor.white,
    ]

    let navbarcolor = UIColor(red: 0.3608, green: 0.5843, blue: 0.8705, alpha: 1)
    let searchbarcolor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
    
    
    var body: some View {
        NavigationView {
            
            SearchingView(searchText: $searchText, APIoutput: APIoutput, selectedKey: selectedKey, output: output)
                .searchable(text: $searchText, prompt: "Search food")
            //add , placement: .navigationBarDrawer(displayMode: .always) to make search bar always stay
                .autocorrectionDisabled(true)
                .navigationBarTitle(x[selectedKey]!)
                .navigationBarColor(Color("NavBar color"))

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
            .onAppear {
                let newNavBarAppearance = UINavigationBarAppearance()
                
                let appearance = UINavigationBar.appearance()
                newNavBarAppearance.configureWithOpaqueBackground()
                newNavBarAppearance.backgroundColor = navbarcolor
                newNavBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                newNavBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = searchbarcolor
                UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .black
                UINavigationBar.appearance().titleTextAttributes = attrs
                
                
                appearance.scrollEdgeAppearance = newNavBarAppearance
                appearance.compactAppearance = newNavBarAppearance
                appearance.standardAppearance = newNavBarAppearance
//                UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance

            }
            

        
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
    @State private var selectedView = 0

    var APIoutput : [String: [String : [String] ]]
    var selectedKey : String
    var output : [Hall]
    let NoData = ["No Data displayed" : ["Nothing to show"]]
    
    @State var selectedItems = Set<String>() // set to store selected items
    
    @AppStorage("selectedItems") var selectedItemsData: Data = Data()
    
    // Convert selectedItems set to data and save to UserDefaults
    func saveSelectedItems() {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(Array(selectedItems))
            selectedItemsData = data
            print(selectedItems)
        } catch {
            print("Error saving selected items: \(error)")
        }
    }
    
    // Retrieve selectedItems data from UserDefaults and convert to set
    func loadSelectedItems() {
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode([String].self, from: selectedItemsData)
            selectedItems = Set(data)
        } catch {
            print("Error loading selected items: \(error)")
        }
    }
    
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
                                Text(itemData.food.replacingOccurrences(of: "&amp;", with: "&"))
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
                    Section(footer:FooterView(APIoutput: APIoutput, selectedKey: selectedKey, output: output, selectedView: $selectedView)){
                        if selectedView == 0{
                            ScrollView {
                                ZStack {
                                    VStack {
                                        //Dining Hall buttons
                                        VStack{
                                            //for each for
                                            
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
                        else{
                            VStack{
                                let hallNames = Array(APIoutput.keys).sorted {$0 < $1}
                                let res = Dictionary(uniqueKeysWithValues:
                                                        hallNames.map { name in
                                    (name, Hall(selectedKey: selectedKey, name: name, dishes: APIoutput[name] ?? NoData))
                                }
                                )
                                
                                let searchData = getData().filter { selectedItems.contains($0.food) }
                                ScrollView{
                                    ForEach(searchData, id: \.id) { itemData in
                                        Divider()
                                        Button(action: {
                                            // Do something here if you need to
                                        }) {
                                            NavigationLink(destination: Menu(hall: res[itemData.hallname]!)) {
                                                VStack(alignment: .leading, spacing: 4) {
                                                    Text(itemData.food.replacingOccurrences(of: "&amp;", with: "&"))
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
                                    .navigationBarTitle("Favorites Available Today", displayMode: .inline)
                                }
                                
                                
                                
                            }
                            .onAppear {
                                loadSelectedItems()
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
    
    
    

