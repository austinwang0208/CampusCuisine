//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCSBfixed() -> [Hall] {
    let CoralTreeCafeData = Hall(
        name: "Coral Tree Cafe",
        //image: "Coral Tree Cafe",
        fixed_menu: ["Coral Tree Cafe Menu"],
        sections: 1
    )
    
    let CourtyardCafeData = Hall(
        name: "Courtyard Cafe",
        //image: "Courtyard Cafe",
        fixed_menu: ["Courtyard Cafe Menu"],
        sections: 1
    )
    let RomainesData = Hall(
        name: "Romaine's",
        //image: "Romaine's",
        fixed_menu: ["Romaine's Menu"],
        sections: 1
    )
    let RootBurgerData = Hall(
        name: "Root Burger",
        //image: "Root Burger",
        fixed_menu: ["Root Burger Menu"],
        sections: 1
    )
    let SummitCafeData = Hall(
        name: "Summit Cafe",
        //image: "Summit Cafe",
        fixed_menu: ["Summit Cafe Menu"],
        sections: 1
    )

    
    
    let output = [CoralTreeCafeData, CourtyardCafeData, RomainesData, RootBurgerData, SummitCafeData]
    return output
}
