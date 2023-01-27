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
            Text("COMING SOON")
                .font(.system(size: 45, weight: .bold, design: .default))
                .foregroundColor(.black)
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
