//
//  getUTAfixed.swift
//  UCLA Dining
//
//  Created by Ish Khandelwal on 3/2/23.
//

import Foundation

func getUTAfixed() -> [Hall] {
    let ChicFilAData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Chic Fil A",
        //image: "Crepe Bistro",
        fixed_menu: ["Chic Fil A Menu 1"],
        sections: 1
    )
    
    let PandaExpressData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Panda Express",
        //image: "The Coffee Bean",
        fixed_menu: ["Panda Express Menu 1", "Panda Express Menu 2", "Panda Express Menu 3", "Panda Express Menu 4", "Panda Express Menu 5"],
        sections: 5 ,
        section_names: ["Main Menu", "Entree", "Sides", "Appetizers", "Drinks"]
    )
    let ShakeSmartData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Shake Smart",
        //image: "Crepe Bistro",
        fixed_menu: ["Shake Smart Menu 1"],
        sections: 1
    )
    let TowerData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Tower Burger",
        //image: "Crepe Bistro",
        fixed_menu: ["Tower Burger Menu 1"],
        sections: 1
    )
    let UnionCoffeeData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Union Coffee House",
        //image: "Crepe Bistro",
        fixed_menu: ["Union Coffee House Menu 1"],
        sections: 1
    )
  

    let output = [ChicFilAData, PandaExpressData, ShakeSmartData, TowerData, UnionCoffeeData]
    return output
}

