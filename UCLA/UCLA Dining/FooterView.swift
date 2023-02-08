//
//  FooterView.swift
//  UCLA Dining
//
//  Created by Austin Wang on 2/3/23.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack{
            Button(action: {}, label: {
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundColor(.primary)
            }).frame(maxWidth: .infinity)
            
            Button(action: {}, label: {
                Image(systemName: "square.and.arrow.up")
                    .font(.title2)
                    .foregroundColor(.primary)
            }).frame(maxWidth: .infinity)
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .font(.title2)
                    .foregroundColor(.black)
            }.frame(maxWidth: .infinity)
        }.background(Color.white)
    }

}



    
//struct FooterView_Previews: PreviewProvider {
//    static let APIpreview = ["Epicuria at Covel" :["Breakfast" : ["eggs", "bacon", "cheese"],"Lunch" : ["sandwhich", "burgers", "fries"],"Dinner" : ["nachos", "pasta", "soda"]],"De Neve" :
//                                [
//                                    "Breakfast" : ["cereal", "oatmeal", "eggs"],
//                                    "Lunch" : ["Noodles", "Chicken", "Bistro"],
//                                    "Dinner" : ["Tenders", "Salad", "Tomatoe Soup"]
//                                ],
//
//                             "Bruin Plate" :
//                                [
//                                    "Breakfast" : ["Bread", "Coffee", "Fruits"],
//                                    "Lunch" : ["Falafels", "Pizza", "French Fries"],
//                                    "Dinner" : ["Tacos", "Quesadillas", "Chicken Tikka"]
//                                ]
//    ]
//    static var previews: some View {
//        ContentView(APIoutput: APIpreview,
//                     output: getFixedMenus(selectedKey: "diningmenus"),
//                     selectedKey: "diningmenus")
//    }
//}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
