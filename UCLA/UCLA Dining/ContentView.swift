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
    var hours : [String: [String : [[Float]]]]
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
            
            SearchingView(searchText: $searchText, APIoutput: APIoutput, hours: hours, selectedKey: selectedKey, output: output)
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
    @State private var ifdininghalls: Bool = false
    @State private var ifrestaurants: Bool = false
    @State var opendict: [String: String] = [:]
    var APIoutput : [String: [String : [String] ]]
    var hours : [String: [String : [[Float]] ]]
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
                ForEach(searchData.indices, id: \.self) { index in
                    let itemData = searchData[index]
                    let isLastItem = index == searchData.count - 1
                    Divider()
                    Button(action: {
                        // Do something here if you need to
                    }) {
                        NavigationLink(destination: Menu(hall: res[itemData.hallname]!)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(itemData.food.replacingOccurrences(of: "&amp;", with: "&"))
                                    .font(.system(size:17, weight: .medium, design: .default))
                                    .lineLimit(1)
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
                    if isLastItem {
                        Divider()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

                } else {
                    Section(footer:
                        FooterView(APIoutput: APIoutput, selectedKey: selectedKey, output: output, selectedView: $selectedView)
                    ){
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
                                                    if ifdininghalls{
                                                        FoodIcon(hall: hallData, hours: hours, open: opendict[hallData.name]!)
                                                            .overlay(
                                                                RoundedRectangle(cornerRadius: 20)
                                                                    .fill(opendict[hallData.name] == "Closed" ? Color.gray.opacity(0.5) : Color.clear)
                                                                    .frame(width: 350, height: 200)
                                                            )
                                                            
                                                    }
                                                }.onAppear(){
                                                    changeTime(hall: hallData)
                                                    ifdininghalls = true
                                                    
                                                }
                                            }
                                        }
                                        .padding()
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
                                            if ifrestaurants{
                                                FoodIcon(hall: hall, hours: hours, open: opendict[hall.name]!)
                                                    .overlay(
                                                        RoundedRectangle(cornerRadius: 20)
                                                            .fill(opendict[hall.name] == "Closed" ? Color.gray.opacity(0.5) : Color.clear)
                                                            .frame(width: 350, height: 200)
                                                    )
                                                
                                            }
                                        }
                                        ).onAppear(){
                                            changeTime(hall: hall)
                                            ifrestaurants = true
                                            
                                        }
                                    }
                                    
                                }
                            }
                        }
                        else{
                            VStack{
                                // Get a sorted array of hall names
                                let hallNames = Array(APIoutput.keys).sorted {$0 < $1}

                                // Create a dictionary of Hall objects keyed by hall names
                                let halls = hallNames.reduce(into: [String: Hall]()) { result, name in
                                    let dishes = APIoutput[name] ?? NoData
                                    let hall = Hall(selectedKey: selectedKey, name: name, dishes: dishes)
                                    result[name] = hall
                                }
                                let selectedItemsFiltered = selectedItems.filter { item in
                                    return getData().contains { data in
                                        return data.food == item
                                    }
                                }

                                // Create a scrollable view
                                ScrollView {
                                    // Iterate over selected items
                                    ForEach(Array(selectedItemsFiltered), id: \.self) { itemData in
                                        Divider()

                                        // Filter data by item
                                        let searchData = getData()
                                            .compactMap { $0.food == itemData ? $0 : nil }

                                        // Create a disclosure group for the item
                                        
                                        VStack {
                                            DisclosureGroup {
                                                // Iterate over filtered data
                                                ForEach(searchData, id: \.id) { itemData in
                                                    NavigationLink(destination: Menu(hall: halls[itemData.hallname]!)) {
                                                        HStack {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                Text(itemData.hallname.replacingOccurrences(of: "&amp;", with: "&"))
                                                                    .font(.system(size:17, weight: .medium, design: .default))
                                                                    .lineLimit(1)
                                                                Group {
                                                                    Text(itemData.mealtime)
                                                                }
                                                                .foregroundColor(.gray)
                                                                .font(.system(size:15, weight: .medium, design: .default))
                                                            }
                                                            Spacer()
                                                            Image(systemName: "heart.fill")
                                                                .foregroundColor(.red)
                                                        }
                                                        .padding(.horizontal, 16)
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .padding(.top, searchData.first?.id == itemData.id ? 8 : 0) // add padding to the top of the first item in each DisclosureGroup
                                                    }
                                                    if searchData.last?.id != itemData.id {
                                                        Divider()
                                                    }
                                                }
                                            } label: {
                                                Text(itemData.replacingOccurrences(of: "&amp;", with: "&"))
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                                    .lineLimit(1)
                                                Divider()
                                            }
                                            .padding(.vertical, 8)
                                            .padding(.horizontal, 8)
                                        }



                                    }
                                    Divider()
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
    
    func changeTime(hall: Hall){
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "HH:mm:ss"
        let localTime = dateFormatter.string(from: Date())
        let timeComponents = localTime.split(separator: ":").compactMap { Int($0) }
        let decimalTime = Double(timeComponents[0]) + Double(timeComponents[1]) / 60.0 + Double(timeComponents[2]) / 3600.0
        
        let date = Date() // get the current date
        let calendar = Calendar.current // get the current calendar
        let weekDay = calendar.component(.weekday, from: date) // get the day of the week (Sunday is 1, Monday is 2, etc.)
        
        let hallHours = hours[hall.name]![String(weekDay)]!
        for i in hallHours{
            if (Float(decimalTime) > i[0]) && (Float(decimalTime) < i[1]){
                var number = i[1]
                var meridiem = ""
                if i[1] < 12{
                    meridiem += "AM"
                } else {
                    meridiem += "PM"
                    number -= 12
                }
                var remainder = Float(0.0)
                if round(number) != number{
                    remainder = number.truncatingRemainder(dividingBy: 1)
                    remainder *= 60
                }
                if remainder == 0{
                    meridiem = "\(Int(floor(number))):\(Int(remainder))\(Int(remainder)) \(meridiem)"
                } else{
                    meridiem = "\(Int(floor(number))):\(Int(remainder)) \(meridiem)"
                }
                print(number)
                opendict[hall.name] = "Open until \(meridiem)"
            }
            if (i[1] - Float(decimalTime) <= 1) && (opendict.keys.contains(hall.name)) && (opendict[hall.name]!.prefix(4) == "Open"){
                let minutes = (i[1] - Float(decimalTime)) * 60
                let str = "Closing in \(Int(minutes))m"
                opendict[hall.name] = str
            }
            if ((i[0] - Float(decimalTime)) < 1) && ((i[0] - Float(decimalTime)) > 0) {
                let minutes = (i[0] - Float(decimalTime)) * 60
                let str = "Opens in \(Int(minutes))m"
                opendict[hall.name] = str
            }
        }
        if !(opendict.keys.contains(hall.name)) {
            opendict[hall.name] = "Closed"
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

        static let hours = [
            "Epicuria at Covel": [
                "1" : [[17.0, 21.0]],
                "2" : [[17.0, 21.0]],
                "3" : [[17.0, 21.0]],
                "4" : [[17.0, 21.0]],
                "5" : [[17.0, 21.0]],
                "6" : [[17.0, 21.0]],
                "7" : [[17.0, 21.0]]
            ],
            "De Neve": [
                "1" : [[17.0, 21.0]],
                "2" : [[17.0, 21.0]],
                "3" : [[17.0, 21.0]],
                "4" : [[17.0, 21.0]],
                "5" : [[17.0, 21.0]],
                "6" : [[17.0, 21.0]],
                "7" : [[17.0, 21.0]]
            ],
            "Bruin Plate": [
                "1" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "2" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "3" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "4" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "5" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "6" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]],
                "7" : [[7.0, 10.0], [11.5, 15.0], [17.0, 21.0]]
            ],
            "Bruin Cafe": [
                "1" : [[25.0, 25.0]],
                "2" : [[11.0, 14.0], [17.0, 21.0]],
                "3" : [[11.0, 14.0], [17.0, 21.0]],
                "4" : [[11.0, 14.0], [17.0, 21.0]],
                "5" : [[11.0, 14.0], [17.0, 21.0]],
                "6" : [[11.0, 14.0], [17.0, 21.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Epicuria at Ackerman": [
                "1" : [[25.0, 25.0]],
                "2" : [[11.0, 16.0], [17.0, 21.0]],
                "3" : [[11.0, 16.0], [17.0, 21.0]],
                "4" : [[11.0, 16.0], [17.0, 21.0]],
                "5" : [[11.0, 16.0], [17.0, 21.0]],
                "6" : [[11.0, 16.0], [17.0, 21.0]],
                "7" : [[25.0, 25.0]]
            ],
            "The Drey": [
                "1" : [[25.0, 25.0]],
                "2" : [[11.0, 14.0], [17.0, 21.0]],
                "3" : [[11.0, 14.0], [17.0, 21.0]],
                "4" : [[11.0, 14.0], [17.0, 21.0]],
                "5" : [[11.0, 14.0], [17.0, 21.0]],
                "6" : [[11.0, 14.0], [17.0, 21.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Rendezvous": [
                "1" : [[11.0, 14.0], [17.0, 21.0]],
                "2" : [[11.0, 14.0], [17.0, 21.0]],
                "3" : [[11.0, 14.0], [17.0, 21.0]],
                "4" : [[11.0, 14.0], [17.0, 21.0]],
                "5" : [[11.0, 14.0], [17.0, 21.0]],
                "6" : [[11.0, 14.0], [17.0, 21.0]],
                "7" : [[11.0, 14.0], [17.0, 21.0]]
            ],
            "De Neve Late Night": [
                "1" : [[21.0, 24.0]],
                "2" : [[21.0, 24.0]],
                "3" : [[21.0, 24.0]],
                "4" : [[21.0, 24.0]],
                "5" : [[21.0, 24.0]],
                "6" : [[21.0, 24.0]],
                "7" : [[21.0, 24.0]]
            ],
            "The Study at Hedrick": [
                "1" : [[11.0, 15.0], [17.0, 24,0]],
                "2" : [[7.0, 10.0], [11.0, 14.0], [17.0, 24.0]],
                "3" : [[7.0, 10.0], [11.0, 14.0], [17.0, 24.0]],
                "4" : [[7.0, 10.0], [11.0, 14.0], [17.0, 24.0]],
                "5" : [[7.0, 10.0], [11.0, 14.0], [17.0, 24.0]],
                "6" : [[7.0, 10.0], [11.0, 14.0], [17.0, 24.0]],
                "7" : [[11.0, 15.0], [17.0, 24,0]]
            ],
            "The Spice Kitchen": [
                "1" : [[25.0, 25.0]],
                "2" : [[17.0, 24.0]],
                "3" : [[17.0, 24.0]],
                "4" : [[17.0, 24.0]],
                "5" : [[17.0, 24.0]],
                "6" : [[17.0, 24.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Burger Assembly": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 20.0]],
                "3" : [[7.0, 20.0]],
                "4" : [[7.0, 20.0]],
                "5" : [[7.0, 20.0]],
                "6" : [[7.0, 16.0]],
                "7" : [[11.0, 15.0]]
            ],
            "Epazote Mexican Grill": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 20.0]],
                "3" : [[7.0, 20.0]],
                "4" : [[7.0, 20.0]],
                "5" : [[7.0, 20.0]],
                "6" : [[7.0, 16.0]],
                "7" : [[11.0, 15.0]]
            ],
            "Tossed": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 20.0]],
                "3" : [[7.0, 20.0]],
                "4" : [[7.0, 20.0]],
                "5" : [[7.0, 20.0]],
                "6" : [[7.0, 16.0]],
                "7" : [[11.0, 15.0]]
            ],
            "Fusion": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 20.0]],
                "3" : [[7.0, 20.0]],
                "4" : [[7.0, 20.0]],
                "5" : [[7.0, 20.0]],
                "6" : [[7.0, 16.0]],
                "7" : [[11.0, 15.0]]
            ],
            "Jimmy's": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 21.0]],
                "3" : [[7.0, 20.0]],
                "4" : [[7.0, 20.0]],
                "5" : [[7.0, 20.0]],
                "6" : [[7.0, 17.0]],
                "7" : [[10.0, 15.0]]
            ],
            "Anderson Cafe": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 19.0]],
                "3" : [[7.0, 19.0]],
                "4" : [[7.0, 19.0]],
                "5" : [[7.0, 19.0]],
                "6" : [[7.0, 18.0]],
                "7" : [[8.0, 17.0]]
            ],
            "Northern Lights": [
                "1" : [[25.0, 25.0]],
                "2" : [[25.0, 25.0]],
                "3" : [[25.0, 25.0]],
                "4" : [[25.0, 25.0]],
                "5" : [[25.0, 25.0]],
                "6" : [[25.0, 25.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Pizza Fresca": [
                "1" : [[25.0, 25.0]],
                "2" : [[25.0, 25.0]],
                "3" : [[25.0, 25.0]],
                "4" : [[25.0, 25.0]],
                "5" : [[25.0, 25.0]],
                "6" : [[25.0, 25.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Southern Lights": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 19.0]],
                "3" : [[7.0, 19.0]],
                "4" : [[7.0, 19.0]],
                "5" : [[7.0, 19.0]],
                "6" : [[7.0, 19.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Yoshinoya": [
                "1" : [[25.0, 25.0]],
                "2" : [[17.0, 24.0]],
                "3" : [[17.0, 24.0]],
                "4" : [[17.0, 24.0]],
                "5" : [[17.0, 24.0]],
                "6" : [[17.0, 24.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Cafe Synapse": [
                "1" : [[25.0, 25.0]],
                "2" : [[9.0, 20.0]],
                "3" : [[9.0, 20.0]],
                "4" : [[9.0, 20.0]],
                "5" : [[9.0, 20.0]],
                "6" : [[9.0, 20.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Plateia": [
                "1" : [[7.0, 22.0]],
                "2" : [[7.0, 22.0]],
                "3" : [[7.0, 22.0]],
                "4" : [[7.0, 22.0]],
                "5" : [[7.0, 22.0]],
                "6" : [[7.0, 22.0]],
                "7" : [[7.0, 22.0]]
            ],
            "Taco Bell": [
                "1" : [[25.0, 25.0]],
                "2" : [[9.5, 18.0]],
                "3" : [[9.5, 18.0]],
                "4" : [[9.5, 18.0]],
                "5" : [[9.5, 18.0]],
                "6" : [[9.5, 18.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Wetzel's Pretzels": [
                "1" : [[25.0, 25.0]],
                "2" : [[9.5, 17.0]],
                "3" : [[9.5, 17.0]],
                "4" : [[9.5, 17.0]],
                "5" : [[9.5, 17.0]],
                "6" : [[9.5, 17.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Carl's Junior": [
                "1" : [[8.5, 16.0]],
                "2" : [[8.0, 19.0]],
                "3" : [[8.0, 19.0]],
                "4" : [[8.0, 19.0]],
                "5" : [[8.0, 19.0]],
                "6" : [[8.0, 19.0]],
                "7" : [[8.5, 17.0]]
            ],
            "Music Cafe": [
                "1" : [[25.0, 25.0]],
                "2" : [[7.0, 18.0]],
                "3" : [[7.0, 18.0]],
                "4" : [[7.0, 18.0]],
                "5" : [[7.0, 18.0]],
                "6" : [[7.0, 17.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Kerckhoff Coffee House": [
                "1" : [[8.0, 20.0]],
                "2" : [[7.0, 22.0]],
                "3" : [[7.0, 22.0]],
                "4" : [[7.0, 22.0]],
                "5" : [[7.0, 22.0]],
                "6" : [[8.0, 19.0]],
                "7" : [[8.0, 20.0]]
            ],
            "Lollicup Express": [
                "1" : [[25.0, 25.0]],
                "2" : [[9.5, 17.0]],
                "3" : [[9.5, 17.0]],
                "4" : [[9.5, 17.0]],
                "5" : [[9.5, 17.0]],
                "6" : [[9.5, 17.0]],
                "7" : [[25.0, 25.0]]
            ],
            "Panda Express": [
                "1" : [[11.0, 16.0]],
                "2" : [[9.5, 21.0]],
                "3" : [[9.5, 21.0]],
                "4" : [[9.5, 21.0]],
                "5" : [[9.5, 21.0]],
                "6" : [[9.5, 21.0]],
                "7" : [[11.0, 17.0]]
            ],
            "Veggie Grill": [
                "1" : [[11.0, 17.0]],
                "2" : [[10.0, 21.0]],
                "3" : [[10.0, 21.0]],
                "4" : [[10.0, 21.0]],
                "5" : [[10.0, 21.0]],
                "6" : [[10.0, 21.0]],
                "7" : [[11.0, 16.0]]
            ],
            "Rubios": [
                "1" : [[11.0, 15.0]],
                "2" : [[10.0, 21.0]],
                "3" : [[10.0, 21.0]],
                "4" : [[10.0, 21.0]],
                "5" : [[10.0, 21.0]],
                "6" : [[10.0, 21.0]],
                "7" : [[11.0, 17.0]]
            ]
        ]

        
        static var previews: some View {
            // 5. Use the right SecondView initializator
            ContentView(APIoutput: APIpreview,
                        hours: convertToFloat(hours),
                        output: getFixedMenus(selectedKey: "diningmenus"),
                        selectedKey: "diningmenus")
        }
    }


func convertToFloat(_ dict: [String: [String: [[Double]]]]) -> [String: [String: [[Float]]]] {
    var result = [String: [String: [[Float]]]]()
    for (key1, value1) in dict {
        var innerDict = [String: [[Float]]]()
        for (key2, value2) in value1 {
            var floatArray = [[Float]]()
            for arr in value2 {
                let floatArr = arr.map { Float($0) }
                floatArray.append(floatArr)
            }
            innerDict[key2] = floatArray
        }
        result[key1] = innerDict
    }
    return result
}
