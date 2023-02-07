///
//  Menu.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/20/22.
//

import Foundation
import SwiftUI

struct fixed_menu: View {
    // Use a scale effect to zoom in and out
    var hall: Hall
    var body: some View {
        ZStack {
                if hall.sections! <= 1 {
                    Fixed_Menu_Section(hall: hall, section_number: 0)
                }
                else {
                    if hall.fixed_menu != nil {
                        TabView {
                            ForEach(0..<hall.sections!, id: \.self) { index in
                                Fixed_Menu_Section(hall: hall, section_number: index)
                                    .tabItem {
                                        Image(systemName: "circle")
                                        Text(hall.section_names![index])
                                    }
                            }
                        }
                    }
                }
        }.navigationBarTitle(hall.name)
            .toolbarBackground(
                Color("NavBar color"),
                for: .navigationBar)

            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct fixed_menu_Previews: PreviewProvider {
    static let HallPreview = Hall(
        name: "Bruin Cafe",
        //dishes: ["default", "preview", "menu"],
        image: "Bruin Cafe",
        fixed_menu: ["Bruin Cafe fixed menu 1", "Bruin Cafe fixed menu 2"],
        sections: 2,
        section_names: ["Lunch & Dinner", "Smoothies and Coffee"]

    )
    
    static var previews: some View {
        // 5. Use the right SecondView initializator
        fixed_menu(hall: HallPreview)
    }
}
