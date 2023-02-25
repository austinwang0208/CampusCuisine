//
//  getUCSCfixed.swift
//  UCLA Dining
//
//  Created by Ish Khandelwal on 2/24/23.
//

import Foundation

func getUCSCfixed() -> [Hall] {
    let IvetaData = Hall(
        selectedKey: "ucscdiningmenus",
        name: "Iveta",
        //image: "Crepe Bistro",
        fixed_menu: ["Iveta Menu 1"],
        sections: 1
    )
    let GlobalVillageData = Hall(
        selectedKey: "ucscdiningmenus",
        name: "Global Village Cafe",
        //image: "Crepe Bistro",
        fixed_menu: ["Global Village Cafe Menu 1"],
        sections: 1
    )

    
    
    let output = [IvetaData, GlobalVillageData]
    return output
}
