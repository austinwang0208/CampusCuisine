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
                VStack(spacing: 0) {
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
                                VStack {
                                    Text("Change University")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 20)
                                    Image("\(selectedKey!) designer text")
                                        .padding(.vertical, 20)
                                    //.font(.system(size: 18, design: .default))
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .buttonStyle(BorderlessButtonStyle())
                            .sheet(isPresented: $isPresented) {
                                FillInView(selectedKey: $selectedKey, refresh: $refresh)
                            }
                        }.frame(height: 450)
                        //.listStyle(PlainListStyle())
                        //Text("Help us Out!")
                        //    .font(.system(size:28, weight: .medium, design: .default))
                        //    .foregroundColor(.black)
                        
                    List {
                        
                        NavigationLink(destination: LeaveUsAReviewView()) {
                            Text("Rate our App:")
                                .font(.headline)
                                .padding(.vertical, 20)
                        }
                            
                        NavigationLink(destination: SuggestionsForm()) {
                            Text("Have something to report?")
                                .font(.headline)
                                .padding(.vertical, 20)
                        }
                    }//.listStyle(PlainListStyle())
                }
                }
            }.navigationBarTitle("Settings", displayMode: .inline)
            //.navigationBarHidden(!showNavigationBar)
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
