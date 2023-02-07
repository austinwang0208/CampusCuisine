

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
        ScrollViewReader( { proxy in
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
                            let x = ["Breakfast", "Brunch", "Lunch", "Dinner", "Late Night"]
                            let y = hall.dishes!.keys.sorted()
                            let common: [String] = {
                                x.filter { y.contains($0) }
                            }()
                            //                        let common = Array(x.intersection(Set(y)))
                            ForEach(Array(common), id: \.self) { key in
                                Section(header: Text(key)) {
                                    ForEach(hall.dishes![key]!, id: \.self) { value in
                                        Text(value)
                                    }
                                }.id(key)
                            }
                        }
                        
                    }
                    
                    VStack {
                        BannerAd(unitID: "ca-app-pub-7275807859221897/8994587990")
                    }.frame(height: 45)
                }
            }.safeAreaInset(edge: .top){
                let x = ["Breakfast", "Brunch", "Lunch", "Dinner", "Late Night"]
                let y = hall.dishes!.keys.sorted()
                let common: [String] = {
                    x.filter { y.contains($0) }
                }()
                HStack(spacing:20){
                    ForEach(Array(common), id: \.self) { key in
                        Button{
                            proxy.scrollTo(key, anchor: .top)
                            
                        }label:{
                            Text(key)
                        }
                    }
                }
                
                .frame(width:350)
                .padding(.vertical)
                .background(.white)
                .cornerRadius(10)
                .padding(.bottom)
            }
            
            
        }
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
        name: "sample dining hall",
        dishes: ["Breakfast" : ["eggs", "ham", "cereal"], "Lunch" : ["Sandwhich", "Pasta", "Burrito"], "Dinner" : ["Nachos", "Soup", "Chicken"], "Late Night": []],
        image: "Epicuria at Covel"
    )

    static var previews: some View {
        // 5. Use the right SecondView initializator
        Menu(hall: HallPreview)
    }
}
