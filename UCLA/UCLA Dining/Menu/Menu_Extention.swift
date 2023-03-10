//
//  Menu_Extention.swift
//  UCLA Dining
//
//  Created by Austin Wang on 3/8/23.
//

import Foundation

import SwiftUI

extension Menu {
    final class ViewModel: ObservableObject {
        @Published var showingFavs = false
        @Published var savedItems: Set<Int> = [1, 7]
        
        
        private var db = Database()
        
        init() {
            self.savedItems = db.load()
        }

    }
}
