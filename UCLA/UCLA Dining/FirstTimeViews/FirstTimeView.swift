//
//  FirstTimeView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/15/23.
//

import SwiftUI



struct FirstTimeView: View {
    
    //for retrieving school name
    @State private var isPresented: Bool = false
    @State private var selectedKey: String? = UserDefaults.standard.string(forKey: "selectedKey")
    
    var body: some View {
        if selectedKey != nil {
            LaunchAnimation(selectedKey: selectedKey ?? "something wrong")
        }
        else {
            GeometryReader { geometry in
//                RadialGradient(gradient: Gradient(colors: [.gray, .black]), center: .center, startRadius: 0.2, endRadius: 650)
                LinearGradient(gradient: Gradient(colors: [Color(red:80/255, green: 80/255, blue: 80/255), Color(red:20/255, green: 20/255, blue: 20/255), Color(red:10/255, green: 10/255, blue: 10/255)]), startPoint: .topTrailing, endPoint: .bottomLeading)
                    .edgesIgnoringSafeArea(.all)
                Image("Campus Dining")
                        .resizable()
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.1)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.9)


                
//                Button("Select Your University") {
//                    self.isPresented = true
//                }
//                .frame(width: 200, height: 50)
////                .background(Color(red: 0.11372549019, green: 0.55294117647, blue: 0.93333333333 ))
//                .underline()
//                .background(.black)
//                .foregroundColor(.white)
//                .cornerRadius(25)
//                .buttonStyle(BorderlessButtonStyle())
//                .foregroundColor(.blue)
//
//                .position(x: geometry.size.width / 2, y: geometry.size.height * 12/20)
//                .font(.custom("AppleSDGothicNeo-Bold", size: 18))
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
                .position(x: geometry.size.width / 2, y: geometry.size.height * 12/20)
//                .font(.custom("Calibri-Bold", size: 20, weight: .heavy))
                .sheet(isPresented: $isPresented) {
                    FillInView(selectedKey: self.$selectedKey)
                }
            }
        }
    }
}

struct FirstTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FirstTimeView()
    }
}
