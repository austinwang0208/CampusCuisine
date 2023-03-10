//
//  FavoritesView.swift
//  UCLA Dining
//
//  Created by Austin Wang on 3/9/23.
//

import SwiftUI

struct FavoritesView: View {
    
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
//
//struct FavoritesView_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoritesView(APIoutput: APIoutput, selectedKey: selectedKey, output: output)
//    }
//}
