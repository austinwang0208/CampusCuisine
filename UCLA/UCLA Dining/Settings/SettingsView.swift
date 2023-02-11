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
        //ZStack {
            VStack {
                //ScrollView {
                    ChangeSchools(changeSchools: $changeSchools)
                    if (changeSchools == false) {
                        //LeaveUsAReviewView()
                        
                        //DevelopersView()
                        
                        SuggestionsForm()
                    }
                //}
            }
        //}
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
