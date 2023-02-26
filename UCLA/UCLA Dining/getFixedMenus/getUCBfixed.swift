//
//  getUCBfixed.swift
//  UCLA Dining
//
//  Created by Ish Khandelwal on 2/26/23.
//

import Foundation

func getUCBfixed() -> [Hall] {
    let BrownsCafeData = Hall(
        selectedKey: "ucbdiningmenus",
        name: "Brown's Cafe",
        //image: "Crepe Bistro",
        fixed_menu: ["Brown's Cafe Menu 1"],
        sections: 1
    )
   let PizzeriaData = Hall(
        selectedKey: "ucbdiningmenus",
        name: "Pizzeria 1868",
        //image: "Crepe Bistro",
        fixed_menu: ["Pizzeria 1868 Menu 1"],
        sections: 1
    )
    let AlmareData = Hall(
        selectedKey: "ucbdiningmenus",
        name: "Almare Gelato",
        //image: "Crepe Bistro",
        fixed_menu: ["Almare Gelato Menu 1"],
        sections: 1
    )
    let LadleData = Hall(
        selectedKey: "ucbdiningmenus",
        name: "Ladle and Leaf",
        //image: "Crepe Bistro",
        fixed_menu: ["Ladle and Leaf Menu 1"],
        sections: 1
    )
    let UnoData = Hall(
        selectedKey: "ucbdiningmenus",
        name: "Uno Express",
        //image: "Crepe Bistro",
        fixed_menu: ["Uno Express Menu 1"],
        sections: 1
    )
    
    
    
    let output = [BrownsCafeData, AlmareData,LadleData,UnoData, PizzeriaData]
    return output
    
}
