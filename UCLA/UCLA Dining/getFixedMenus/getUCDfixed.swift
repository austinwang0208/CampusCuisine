//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCDfixed() -> [Hall] {
    let CrepeBistroData = Hall(
        selectedKey: "ucddiningmenus",
        name: "Crepe Bistro",
        //image: "Crepe Bistro",
        fixed_menu: ["Crepe Bistro Menu 1"],
        sections: 1
    )
    let TheGunrockData = Hall(
        selectedKey: "ucddiningmenus",
        name: "The Gunrock",
        //image: "The Gunrock",
        fixed_menu: ["The Gunrock Menu 1"],
        sections: 1
    )
    let TheSpokesGrill = Hall(
        selectedKey: "ucddiningmenus",
        name: "Spokes Grill",
        //image: "Spokes Grill",
        fixed_menu: ["Spokes Grill Menu 1"],
        sections: 1
    )
    let PeetsCoffee = Hall(
        selectedKey: "ucddiningmenus",
        name: "Peets Coffee",
        //image: "Spokes Grill",
        fixed_menu: ["Peets Coffee Menu 1"],
        sections: 1
    )
    
    
    let output = [CrepeBistroData,TheGunrockData, TheSpokesGrill, PeetsCoffee]
    return output
}
