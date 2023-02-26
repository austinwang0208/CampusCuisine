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
    let College8Data = Hall(
        selectedKey: "ucscdiningmenus",
        name: "College 8 Cafe",
        //image: "Crepe Bistro",
        fixed_menu: ["College 8 Cafe Menu 1"],
        sections: 1
    )
    let OakesData = Hall(
        selectedKey: "ucscdiningmenus",
        name: "Oakes Cafe",
        //image: "Crepe Bistro",
        fixed_menu: ["Oakes Cafe Menu 1"],
        sections: 1
    )
    let StevensonData = Hall(
        selectedKey: "ucscdiningmenus",
        name: "Stevenson Coffee House",
        //image: "Crepe Bistro",
        fixed_menu: ["Stevenson Coffee House Menu 1"],
        sections: 1
    )
    
    let output = [IvetaData, GlobalVillageData,College8Data,StevensonData,OakesData]
    return output
}
