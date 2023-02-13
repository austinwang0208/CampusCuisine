//
//  SettingsView.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/23/23.
//

import SwiftUI

struct SettingsView: View {
    @State private var changeSchools = false
    
    var body: some View {
        ZStack {
            Color.white
            VStack(spacing: 20) {
                ChangeSchools(changeSchools: $changeSchools)
                
                if (changeSchools == false) {
                    VStack(spacing: 20) {
                        NavigationLink(destination: LeaveUsAReviewView()) {
                            Text("Rate our App:")
                                .font(.headline)
                        }.onTapGesture {
                            print("changeSchools: \(changeSchools)")
                        }
                        
                        NavigationLink(destination: SuggestionsForm()) {
                            Text("Have something to report?")
                                .font(.headline)
                        }.onTapGesture {
                            print("changeSchools: \(changeSchools)")
                        }
                    }
                    .padding()
                }
            }
        }
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
