//
//  getUTAfixed.swift
//  UCLA Dining
//
//  Created by Ish Khandelwal on 3/2/23.
//

import Foundation

func getUTfixed() -> [Hall] {
    let ChicFilAData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Chick Fil A - Texas Union",
        //image: "Crepe Bistro",
        fixed_menu: ["Chic Fil A - Texas Union Menu 1"],
        sections: 1
    )
    
    let ChicFilADataWCP = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Chick Fil A - WCP",
        //image: "Crepe Bistro",
        fixed_menu: ["Chic Fil A - WCP Menu 1"],
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
    let Sushidata = Hall(
        selectedKey: "utaustindiningmenus",
        name: "One Two Three Sushi",
        //image: "Crepe Bistro",
        fixed_menu: ["One Two Three Sushi Menu 1"],
        sections: 1
    )
    let TacosData = Hall(
        selectedKey: "utaustindiningmenus",
        name: "Sabor Tacos y Mas",
        //image: "Crepe Bistro",
        fixed_menu: ["Sabor Tacos y Mas Menu 1"],
        sections: 1
    )

    let output = [ChicFilAData, PandaExpressData, ShakeSmartData, TowerData, UnionCoffeeData,Sushidata, TacosData, ChicFilADataWCP]
    return output
}

