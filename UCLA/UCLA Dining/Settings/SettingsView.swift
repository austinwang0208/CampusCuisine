//
//  SettingsView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/23/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack {
            Text("we didn't have time for a button to change schools, so just delete and reinstall the app and choose the school lol")
        }.navigationBarTitle("Settings")
            .toolbarBackground(
                Color("NavBar color"),
                for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
