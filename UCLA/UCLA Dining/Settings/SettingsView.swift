//
//  SettingsView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/23/23.
//

import SwiftUI



struct SettingsView: View {
    @State private var isPresented: Bool = false
    @State private var selectedKey: String? = UserDefaults.standard.string(forKey: "selectedKey")
    @State private var refresh: Bool = false
    var body: some View {
        VStack {
            if refresh != false {
                LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
            }
            else{
                Button(action: {
                    self.isPresented = true
                }) {
                    
                    Text("SELECT YOUR UNIVERSITY")
                        .underline()
                        .foregroundColor(.blue)
                        .font(.system(size: 18, weight: .heavy, design: .default))
                    
                }
                .foregroundColor(.white)
                .buttonStyle(BorderlessButtonStyle())
                //            .position(x: geometry.size.width / 2, y: geometry.size.height * 12/20)
                //                .font(.custom("Calibri-Bold", size: 20, weight: .heavy))
                .sheet(isPresented: $isPresented) {
                    FillInView(selectedKey: $selectedKey, refresh: $refresh)
                }.navigationBarTitle("Settings")
                    .toolbarBackground(
                        Color("NavBar color"),
                        for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                
            }
        }
    }
    }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
