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
    
    let output = [CrepeBistroData,TheGunrockData]
    return output
}
