//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCSBfixed() -> [Hall] {
    let CoralTreeCafeData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Coral Tree Cafe",
        //image: "Coral Tree Cafe",
        fixed_menu: ["Coral Tree Cafe Menu"],
        sections: 1
    )
    
    let CourtyardCafeData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Courtyard Cafe",
        //image: "Courtyard Cafe",
        fixed_menu: ["Courtyard Cafe Menu"],
        sections: 1
    )
    let RomainesData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Romaine's",
        //image: "Romaine's",
        fixed_menu: ["Romaine's Menu"],
        sections: 1
    )
    let RootBurgerData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Root Burger",
        //image: "Root Burger",
        fixed_menu: ["Root Burger Menu"],
        sections: 1
    )
    let SummitCafeData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Summit Cafe",
        //image: "Summit Cafe",
        fixed_menu: ["Summit Cafe Menu"],
        sections: 1
    )

    
    
    let output = [CoralTreeCafeData, CourtyardCafeData, RomainesData, RootBurgerData, SummitCafeData]
    return output
}
