

///
//  Menu.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/20/22.
//

import SwiftUI

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = min(value, nextValue())
    }
}

struct Menu: View {

    
    var hall: Hall
        
    // for ensuring each tab view element is the same size
    @State private var wordHeight: CGFloat = 100
    
    
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
    
    var body: some View {
        ScrollViewReader { proxy in
            ZStack{
                Color.white
                    .ignoresSafeArea(.all)
                //ScrollView {
                VStack {
                    if hall.dishes!.count == 0{
                        Text("No Data Displayed")
                            .font(.system(size:45, weight:.bold, design: .default))
                            .foregroundColor(.gray)
                    }
                    else{
                        List {
                            let x = ["Breakfast", "Brunch", "Lunch","Lunch/Dinner", "Dinner", "Late Night"]
                            let y = hall.dishes!.keys.sorted()
                            let common: [String] = {
                                x.filter { y.contains($0) }
                            }()
                            //                        let common = Array(x.intersection(Set(y)))
                            //if (Array(common).count > 0) {
                            ForEach(Array(common), id: \.self) { key in
                                Section(header: Text(key)) {
                                    if hall.dishes![key]!.count == 0{
                                        Text("No Menu")
                                    }
                                    else{
                                        ForEach(hall.dishes![key]!, id: \.self) { value in
                                            HStack {
                                                Text(value.replacingOccurrences(of: "&amp;", with: "&"))
                                                Spacer()
                                                if selectedItems.contains(value) {
                                                    Button(action: {
                                                        selectedItems.remove(value)
                                                        saveSelectedItems()// unselect item
                                                                                                            }) {
                                                        Image(systemName: "heart.fill")
                                                            .foregroundColor(.red)
                                                    }
                                                } else {
                                                    Button(action: {
                                                        selectedItems.insert(value)
                                                        saveSelectedItems()// select item
                                                    }) {
                                                        Image(systemName: "heart")
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                
                                            }.id(key)
                                                .onAppear {
                                                    loadSelectedItems()
                                                }
                                        }
                                    }}
                                }

                        }
                    }
                    
                    VStack {
                        BannerAd(unitID: "ca-app-pub-7275807859221897/8994587990")
                    }.frame(height: 45)
                }
            }.safeAreaInset(edge: .top){
                let x = ["Breakfast", "Brunch", "Lunch","Lunch/Dinner", "Dinner", "Late Night"]
                let y = hall.dishes!.keys.sorted()
                let common: [String] = {
                    x.filter { y.contains($0) }
                }()
                
                HStack(spacing:0){
                    ForEach(Array(common), id: \.self) { key in
                        Button{
                            withAnimation(.easeInOut(duration: 100)) {
                                proxy.scrollTo(key, anchor: .top)
                            }
                            
                        }label:{
                            Text(key)
                                .font(.system(size: 19, weight: .bold, design: .default))
                                                .foregroundColor(.white)
                                                .font(.largeTitle)
                                                .scaledToFit()
                                                .minimumScaleFactor(0.66)
                                                .lineLimit(1)
                                                .background(GeometryReader {
                                                    Color.clear
                                                        .preference(key: SizePreferenceKey.self, value: $0.size.height)
                                                })
                                                .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: wordHeight)
                        }.onPreferenceChange(SizePreferenceKey.self, perform: { wordHeight = $0 })
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .padding(.horizontal)
                .background(Color("NavBar color"))
                //                .cornerRadius(10)
                //                .frame(width: 350px)
                .padding(.bottom)
            }
            
            
        }
        .navigationBarTitle(hall.name, displayMode: .inline)
                                    .toolbarBackground(
                                        Color("NavBar color"),
                                        for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
    }
    
}
                                
                                
                                
                                
                                //ForEach(0..<hall.dishes!.count, id: \.self) { index in
//                                let meals = ["Breakfast", "Brunch", "Lunch", "Dinner", "Late Night"]
//                                ForEach(0..<meals.count, id: \.self) {index in
//
//                                        Menu_Section(arr: hall.dishes![meals[index]] ?? error)
//                                            .tabItem {
//                                                Image(systemName: "circle")
//                                                Text(meals[index])
//                                            }
//
//                                    }
//
////                                }
//                            }
//
//
//
//
//
//                        }
//                        else {
//                            Text("No Data Displayed")
//                                .font(.system(size: 45, weight: .bold, design: .default))
//                                .foregroundColor(.gray)
//                        }
//                    }
//
//        }.navigationTitle(hall.name)
//            .toolbarBackground(
//                Color("NavBar color"),
//                for: .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
//    }
//}
//
//struct NavigationConfigurator: UIViewControllerRepresentable {
//
//    var configure: (UINavigationController) -> Void = { _ in }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
//        UIViewController()
//    }
//
//    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
//        if let nc = uiViewController.navigationController {
//            self.configure(nc)
//        }
//    }
//
//}
//
//
struct Menu_Previews: PreviewProvider {
    static let HallPreview = Hall(
        selectedKey: "diningmenus",
        name: "sample dining hall",
        dishes: ["Breakfast" : ["Nachos", "ham", "cereal"], "Lunch" : ["Sandwhich", "Pasta", "Burrito"], "Dinner" : ["Nachos", "Soup", "Chicken"], "Late Night": []]
        //image: "Epicuria at Covel"
        )
    static var previews: some View {
        // 5. Use the right SecondView initializator
        Menu(hall: HallPreview)
    }
}
