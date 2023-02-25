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
    let StarbucksData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Starbucks",
        //image: "The Coffee Bean",
        fixed_menu: ["Starbucks Menu"],
        sections: 1
    )
    let PandaExpressData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Panda Express",
        //image: "The Coffee Bean",
        fixed_menu: ["Panda Express Menu 1", "Panda Express Menu 2", "Panda Express Menu 3", "Panda Express Menu 4", "Panda Express Menu 5"],
        sections: 5 ,
        section_names: ["Main Menu", "Entree", "Sides", "Appetizers", "Drinks"]
    )
    let SubwayData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Subway",
        //image: "The Coffee Bean",
        fixed_menu: ["Subway Menu 1"],
        sections: 1
    )
    let JambaJuiceData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Jamba Juice",
        //image: "The Coffee Bean",
        fixed_menu: ["Jamba Juice Menu 1"],
        sections: 1
    )
    let SantoriniIslandGrill = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Santorini Island Grill",
        //image: "The Coffee Bean",
        fixed_menu: ["Santorini Island Grill Menu 1"],
        sections: 1
    )
    let WoodstocksData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Woodstock's at the Arbor",
        //image: "The Coffee Bean",
        fixed_menu: ["Woodstock's at the Arbor Menu 1"],
        sections: 1
    )
    let YoshinoyaData = Hall(
        selectedKey: "ucsbdiningmenus",
        name: "Yoshinoya",
        //image: "The Coffee Bean",
        fixed_menu: ["Yoshinoya Menu 1"],
        sections: 1
    )
    
    let output = [CoralTreeCafeData, CourtyardCafeData, RomainesData, RootBurgerData, SummitCafeData, StarbucksData, PandaExpressData, SubwayData, JambaJuiceData,SantoriniIslandGrill,WoodstocksData,YoshinoyaData]
    return output
}
