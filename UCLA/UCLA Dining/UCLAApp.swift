//
//  UCLAApp.swift
//  UCLA
//
//  Created by Rohan Sehgal on 10/25/22.
//

import SwiftUI
import GoogleMobileAds

@main
struct UCLAApp: App {
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    var body: some Scene {
        WindowGroup {
            FirstTimeView()
        }
    }
}
