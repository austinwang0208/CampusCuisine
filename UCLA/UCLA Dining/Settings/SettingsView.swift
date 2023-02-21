//
//  SettingsView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/23/23.
//

import SwiftUI

struct SettingsView: View {
    //@State private var changeSchools = false
    @State private var isPresented: Bool = false
    @State private var selectedKey: String? = UserDefaults.standard.string(forKey: "selectedKey")
    @State private var refresh: Bool = false
    
    @State private var showNavigationBar = true
    
    var body: some View {
        //NavigationStack {
            ZStack {
                //Color.white
                VStack(spacing: 20) {
                    if refresh != false {
                        LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
                            .navigationBarBackButtonHidden(true)
                            .navigationBarTitle("")
                    }
                    else{
                        List {
                            Button(action: {
                                self.isPresented = true
                                self.showNavigationBar = false
                            }) {
                                
                                Text("SELECT YOUR UNIVERSITY")
                                //.underline()
                                    .foregroundColor(.black)
                                    .font(.system(size: 18, weight: .heavy, design: .default))
                                
                            }
                            .foregroundColor(.white)
                            .buttonStyle(BorderlessButtonStyle())
                            .sheet(isPresented: $isPresented) {
                                FillInView(selectedKey: $selectedKey, refresh: $refresh)
                            }
                            
                            NavigationLink(destination: LeaveUsAReviewView()) {
                                Text("Rate our App:")
                                    .font(.headline)
                            }
                            
                            NavigationLink(destination: SuggestionsForm()) {
                                Text("Have something to report?")
                                    .font(.headline)
                            }
                        }
                    }
                }
            }.navigationBarTitle("Settings", displayMode: .inline)
            .navigationBarHidden(!showNavigationBar)
    }
}


func deleteDir(){
    print("HI")
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
