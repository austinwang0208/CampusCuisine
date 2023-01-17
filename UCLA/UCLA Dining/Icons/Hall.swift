//
//  HallStruct.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/19/22.
//

import Foundation

struct Hall: Hashable {
    var name: String
    var dishes: [String : [String]]?
    var image: String
    var fixed_menu: [String]?
    var sections: Int?
    var section_names: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Hall, rhs: Hall) -> Bool {
        return lhs.name == rhs.name
    }
}
