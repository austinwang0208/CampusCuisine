//
//  ContentView.swift
//  schoolSelector test
//
//  Created by Rohan Sehgal on 1/15/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedKey: String? = UserDefaults.standard.string(forKey: "selectedKey")
    @State private var isPresented: Bool = false
    var body: some View {
        VStack {
            if selectedKey != nil {
                Text("Selected Key: \(selectedKey!)")
                NavigationLink(destination: SelectedView(selectedKey: self.$selectedKey)) {
                    EmptyView()
                }
            } else {
                Button("Select Key") {
                    self.isPresented = true
                }
                .sheet(isPresented: $isPresented) {
                    FillInView(selectedKey: self.$selectedKey)
                }
            }
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
