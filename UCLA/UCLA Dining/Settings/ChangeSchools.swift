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
                LaunchAnimation(selectedKey: selectedKey ?? "something wrong").onAppear {
                    self.changeSchools = self.refresh
                }
            }
            else{
                Button(action: {
                    self.isPresented = true
                }) {
                    
                    Text("SELECT YOUR UNIVERSITY")
                        .underline()
                        .foregroundColor(.black)
                        .font(.system(size: 18, weight: .heavy, design: .default))
                    
                }
                .foregroundColor(.white)
                .buttonStyle(BorderlessButtonStyle())
                .sheet(isPresented: $isPresented) {
                    FillInView(selectedKey: $selectedKey, refresh: $refresh)
                }
                .navigationBarTitle("Settings")
            }
        }
    }
}

struct ChangeSchools_Previews: PreviewProvider {
    static var previews: some View {
        ChangeSchools(changeSchools: .constant(false))
    }
}
