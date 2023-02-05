//
//  ContentView.swift
//  Test
//
//  Created by Austin Wang on 2/2/23.
//

import SwiftUI

struct menuTest: View {
    let menu = Bundle.main.decode([MenuSection].self, from:"menu.json")
    
    var body: some View {
        NavigationView {
            List {
                ForEach(menu) { section in
                    Text (section.name)
                    
                    ForEach(section.items) { item in
                        Text (item.name)
                    }
                }
            }
            .navigationTitle("Menu")
        }
    }
}


