//
//  Menu_Section.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/13/23.
//

import SwiftUI

struct Menu_Section: View {
    var arr: [String]
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea(.all)
            VStack {
                VStack {
                    if arr.count > 0 {
                        ScrollView {
                            ForEach(arr, id: \.self) { dish in
                                Text(dish.replacingOccurrences(of: "&amp;", with: "&"))
                                    .font(.system(size: 20))
                                    .foregroundColor(.black)
                                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 5, trailing: 0))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                    }
                    else {
                        Spacer()
                        Text("No data displayed")
                            .font(.system(size: 45, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                Spacer()
                VStack {
                    BannerAd(unitID: "ca-app-pub-7275807859221897/8994587990")
                }.frame(height: 45, alignment: .bottom)
            }
        }
    }
}

struct Menu_Section_Previews: PreviewProvider {
    static var previews: some View {
        Menu_Section(arr: ["eggs", "bacon", "sausage"])
    }
}
