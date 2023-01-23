///
//  Menu.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/20/22.
//

import SwiftUI

struct Menu: View {
    var hall: Hall
    var body: some View {
        ZStack{
            Color.white
                .ignoresSafeArea(.all)
                    //ScrollView {
                    VStack{
                        if hall.dishes!.count > 0 {
                            let error = ["something", "went", "wrong"]
                            
                            //Add ForEach that will iterate through the individual Hall's mealtimes and display as Text for .tabItem
                            TabView {
                                //ForEach(0..<hall.dishes!.count, id: \.self) { index in
                                let meals = ["All Day", "Breakfast", "Brunch", "Lunch", "Dinner", "Late Night"]
                                ForEach(0..<meals.count, id: \.self) {index in
                                    if hall.dishes!.keys.contains(meals[index]){
                                        Menu_Section(arr: hall.dishes![meals[index]] ?? error)
                                            .tabItem {
                                                Image(systemName: "circle")
                                                Text(meals[index])
                                            }
                                    }
                                    
                                }
                            }
                        }
                        else {
                            Text("No Data Displayed")
                                .font(.system(size: 45, weight: .bold, design: .default))
                                .foregroundColor(.gray)
                        }
                    }
        }.navigationTitle(hall.name)
            .toolbarBackground(
                Color("NavBar color"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    
    var configure: (UINavigationController) -> Void = { _ in }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }
    
}


struct Menu_Previews: PreviewProvider {
    static let HallPreview = Hall(
        name: "sample dining hall",
        dishes: ["Breakfast" : ["eggs", "ham", "cereal"], "Lunch" : ["Sandwhich", "Pasta", "Burrito"], "Dinner" : ["Nachos", "Soup", "Chicken"], "Brunch" : []],
        image: "Epicuria at Covel"
    )
    
    static var previews: some View {
        // 5. Use the right SecondView initializator
        Menu(hall: HallPreview)
    }
}
