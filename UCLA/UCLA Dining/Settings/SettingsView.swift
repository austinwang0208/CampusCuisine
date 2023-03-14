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
    
    @State private var showNavigationBar = true
    
    var body: some View {
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
                                VStack(alignment: .leading) {
                                    Text("Change University:")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                        .padding([.vertical, .horizontal] , 20)
                                    if (selectedKey != nil) {
                                        Image("\(selectedKey!) designer text")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding(.vertical, 20)
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .foregroundColor(.white)
                            .buttonStyle(BorderlessButtonStyle())
                            .sheet(isPresented: $isPresented) {
                                FillInView(selectedKey: $selectedKey, refresh: $refresh)
                            }
                        }.frame(height: 450)
                        
                    List {
                        NavigationLink(destination: SuggestionsForm()) {
                            Text("Have Something to Report?")
                                .font(.headline)
                                .padding([.vertical, .horizontal] , 20)
                        }
                    }
                    VStack {
                        BannerAd(unitID: "ca-app-pub-7275807859221897/8737393464")
                    }.frame(height: 45)
                }
                }
            }.navigationBarTitle("Settings", displayMode: .inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
