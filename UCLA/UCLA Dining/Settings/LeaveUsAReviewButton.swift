//
//  LeaveUsAReviewButton.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 2/9/23.
//

import SwiftUI
import StoreKit

struct LeaveUsAReviewView: View {
    @State private var rating = 0
    
    var body: some View {
        VStack {
            Text("Rate our app")
            HStack {
                ForEach(1...5, id: \.self) { number in
                    Button(action: {
                        self.rating = number
                    }) {
                        Image(systemName: self.rating >= number ? "star.fill" : "star")
                    }
                }
            }
            Button(action: {
                let appId = "1449187448"
                let urlString = "itms-apps://itunes.apple.com/app/id\(appId)?action=write-review"
                
                if let url = URL(string: urlString) {
                    UIApplication.shared.open(url)
                }
            }) {
                Text("Submit")
            }
        }
    }
}



struct LeaveUsAReviewButton_Previews: PreviewProvider {
    static var previews: some View {
        LeaveUsAReviewView()
    }
}
