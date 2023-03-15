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
        GeometryReader{ geometry in
            VStack() {
                if refresh != false {
                    LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("")
                }
                else {
                    ZStack {
                        VStack(spacing: 10){
                            Section{
                                ZStack {
                                    Color.white
                                    VStack {
                                        Text("Looking for a place to eat? Campus Dining got you covered")
                                            .foregroundColor(.black)
                                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)) // add padding
                                            .frame(maxWidth: .infinity)
                                        Text("Discover open dining locations, peruse their menus, search for your favorite foods, and save them to your favorites list with ease!")
                                            .foregroundColor(.black)
                                            .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15)) // add padding
                                            .frame(maxWidth: .infinity)
                                        
                                    }
                                    .frame(height: 200)
                                }
                                .padding(-10)
                                Button(action: {
                                    guard let url = URL(string: "https://diningcampus.wixsite.com/campus-cuisine") else { return }
                                    UIApplication.shared.open(url)
                                }
                                ) {
                                    HStack {
                                        Text("Visit Website")
                                            .foregroundColor(.blue)
                                        Image(systemName: "arrow.right")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding(10)
                            Section {
                                ZStack {
                                    Color.white
                                    VStack {
                                        Text("Your current school is:")
                                        Image("\(selectedKey!) designer text")
                                            .resizable()
                                            .frame(width: 100.0, height: 70.0)
                                        Button(action: {
                                            self.isPresented = true
                                            self.showNavigationBar = false
                                        }) {
                                            Text("Change Your University")
                                                .font(.headline)
                                                .foregroundColor(.black)
                                                .padding()
                                                .frame(width: UIScreen.main.bounds.width, height: 50)
                                                .background(Color(.white))
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.black, lineWidth: 0.5)
                                                )
                                        }
                                        .padding(.top, 10)
                                        .foregroundColor(.white)
                                        .buttonStyle(BorderlessButtonStyle())
                                        .sheet(isPresented: $isPresented) {
                                            FillInView(selectedKey: $selectedKey, refresh: $refresh)
                                        }
                                        
                                    }
                                    .padding(-10)
                                }
                                .frame(height: 200)
                            }
                            Section {
                                ZStack{
                                    Color.white
                                    NavigationLink(destination: SuggestionsForm()) {
                                        HStack {
                                            Text("Have Something to Report?")
                                                .font(.headline)
                                                .padding(.vertical, 20)
                                                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 0)) // add padding
                                            
                                            Spacer()
                                            
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 30)) // add padding
                                        }
                                    }
                                }
                            }
                            .frame(height:50)
                            .padding(.top, 20)
                            Spacer()
                            Spacer()
                            VStack {
                                BannerAd(unitID: "ca-app-pub- REMOVED")
                            }.frame(height: 45)
                        }.frame(height:400)
                    }
                    
                }
            }

            .navigationBarTitle("Settings", displayMode: .inline)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.949, green: 0.949, blue: 0.97, opacity: 1.0))
//            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0)
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
