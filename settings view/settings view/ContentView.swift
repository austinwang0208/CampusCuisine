//
//  ContentView.swift
//  settings view
//
//  Created by Rohan Sehgal on 1/23/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("Settings View")
        }.navigationBarTitle("Settings")
    }
}

struct SelectedView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Selected Key: UCLA")
                Spacer()
            }
            .navigationBarTitle("Selected Key")
            .navigationBarItems(trailing:
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SelectedView()
    }
}
