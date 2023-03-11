//
//  FooterView.swift
//  UCLA Dining
//
//  Created by Austin Wang on 2/3/23.
//

import SwiftUI

struct FooterView: View {
    var APIoutput : [String: [String : [String] ]]
    var selectedKey : String
    var output : [Hall]
    let NoData = ["No Data displayed" : ["Nothing to show"]]
    @Binding var selectedView: Int
    
    var body: some View {
        HStack {
            Button(action: {
                // set selected view to 0 when the left button is clicked
                selectedView = 0
            }, label: {
                Image(systemName: "fork.knife")
                    .font(.title2)
                    .foregroundColor(selectedView == 0 ? Color("NavBar color") : .primary)
            }).frame(maxWidth: .infinity)
            
            Button(action: {
                // set selected view to 1 when the right button is clicked
                selectedView = 1
            }, label: {
                Image(systemName: "heart.fill")
                    .font(.title2)
                    .foregroundColor(selectedView == 1 ? Color("NavBar color") : .primary)
            }).frame(maxWidth: .infinity)
        }.overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.black)
                .offset(y: -18)
                .padding(.horizontal, -100)
        )
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
         FooterView(APIoutput: APIpreview,
                    selectedKey: "diningmenus",
                    output: getFixedMenus(selectedKey: "diningmenus"),
                    selectedView: .constant(0)
        )
    }
}
