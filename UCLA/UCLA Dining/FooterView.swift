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
    
    //for checking screen is big enough to fit footer without padding
    @State var isLargeDevice: Bool = {
        if UIScreen.main.bounds.height > 800 {
            return true
        } else {
            return false
        }
    }()
    
    var body: some View {
        if isLargeDevice{
            ZStack{
                VStack{
                    if selectedView == 1 {
                        VStack {
                            BannerAd(unitID: "ca-app-pub- REMOVED")
                        }.frame(height: 45)
                            .padding(.bottom, 5)
                    }
                    //Spacer()
                    Rectangle()
                        .frame(height: 0.5)
                        .foregroundColor(Color.black)
                        .offset(y: -18)
                        .padding(.horizontal, -100)
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
                    }
                    .padding(.top)
                    .frame(height:20)
//                    .overlay(
//                        Rectangle()
//                            .frame(height: 0.5)
//                            .foregroundColor(Color.black)
//                            .offset(y: -18)
//                            .padding(.horizontal, -100)
//                    )
                }
            }
        }
        else {
            let searchbarcolor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
            ZStack{
                
                VStack{
                    if selectedView == 1 {
                        VStack {
                            BannerAd(unitID: "ca-app-pub- REMOVED")
                        }.frame(height: 45)
                            .padding(.bottom, 5)
                    }
                    ZStack {
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
                        }
                    }
                    .frame(height:15)
//                    .overlay(
//                        Rectangle()
//                            .frame(height: 0.5)
//                            .foregroundColor(Color.black)
//                            .offset(y: -18)
//                            .padding(.horizontal, -100)
//                    )
                }
            }
            .foregroundColor(Color(searchbarcolor))
            .padding()
        }
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
                    selectedView: .constant(1)
        )
    }
}
