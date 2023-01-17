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
                Color.black
                    .edgesIgnoringSafeArea(.all)
                Image("University Dining")
                        .resizable()
                        .position(x: geometry.size.width / 2, y: geometry.size.height * 0.1)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8)
                Button("Select Your University") {
                    self.isPresented = true
                }
                .frame(width: 200, height: 50)
                .background(Color(red: 0.11372549019, green: 0.55294117647, blue: 0.93333333333 ))
                .foregroundColor(.white)
                .cornerRadius(25)

                .position(x: geometry.size.width / 2, y: geometry.size.height * 12/20)
                .font(.custom("ChalkboardSE-Light", size: 18))

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
