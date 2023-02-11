//
//  ChangeSchools.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 2/9/23.
//

import SwiftUI

struct ChangeSchools: View {
    @Binding var changeSchools: Bool
    @State private var isPresented: Bool = false
    @State private var selectedKey: String? = UserDefaults.standard.string(forKey: "selectedKey")
    @State private var refresh: Bool = false
    var body: some View {
        VStack {
            if refresh != false {
                //delete cache folder right here
                LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
            }
            else{
                Button(action: {
                    self.isPresented = true
                    changeSchools = true
                }) {
                    
                    Text("SELECT YOUR UNIVERSITY")
                        .underline()
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .heavy, design: .default))
                    
                }
                .foregroundColor(.white)
                .buttonStyle(BorderlessButtonStyle())
                //            .position(x: geometry.size.width / 2, y: geometry.size.height * 12/20)
                //                .font(.custom("Calibri-Bold", size: 20, weight: .heavy))
                .sheet(isPresented: $isPresented) {
                    FillInView(selectedKey: $selectedKey, refresh: $refresh)
                }.navigationBarTitle("Settings")
                    //.toolbarBackground(
                    //    Color("NavBar color"),
                    //    for: .navigationBar)
                    //.toolbarBackground(.visible, for: .navigationBar)
                
            }
        }
    }
}

struct ChangeSchools_Previews: PreviewProvider {
    static var previews: some View {
        ChangeSchools(changeSchools: .constant(false))
    }
}
