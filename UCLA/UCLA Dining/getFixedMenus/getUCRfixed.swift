//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCRfixed() -> [Hall] {
    let IvansatHinderakerData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Ivans at Hinderaker",
        //image: "Ivan's Coffee Shop",
        fixed_menu: ["Ivans at Hinderaker Menu 1"],
        sections: 1
    )
    
    let BytesData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Bytes",
        //image: "Bytes",
        fixed_menu: ["Bytes Menu 1"],
        sections: 1
    )
    let LollicupFreshBobaData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Lollicup Fresh Boba",
        //image: "Lollicup Fresh Boba",
        fixed_menu: ["Lollicup Fresh Boba Menu 1"],
        sections: 1
    )
    let TheBarnData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "The Barn",
        //image: "The Barn Grill",
        fixed_menu: ["The Barn Menu 1", "The Barn Menu 2"],
        sections: 2 ,
        section_names: ["The Grill", "Patio Bar"]
    )
    let HibachiSanJapaneseGrillData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Hibachi-San Japanese Grill",
        //image: "Hibachi San Japanese Grill",
        fixed_menu: ["Hibachi-San Japanese Grill Menu 1"],
        sections: 1
    )
    let ChronicTacosData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Chronic Tacos",
        //image: "Chronic Tacos",
        fixed_menu: ["Chronic Tacos Menu 1"],
        sections: 1
    )
    let HabitData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "The Habit Burger Grill",
        //image: "The Habit Burger Grill",
        fixed_menu: ["The Habit Burger Grill Menu 1", "The Habit Burger Grill Menu 2", "The Habit Burger Grill Menu 3", "The Habit Burger Grill Menu 4", "The Habit Burger Grill Menu 5", "The Habit Burger Grill Menu 6", "The Habit Burger Grill Menu 7"],
        sections: 7 ,
        section_names: ["Family Bundles", "Charburgers", "Signature Sandwiches", "Popular Meals", "Fresh Salads", "Sides", "Drinks"]
    )
    let HalalShackData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "The Halal Shack",
        //image: "Halal Shack",
        fixed_menu: ["The Halal Shack Menu 1"],
        sections: 1
    )
    let CoffeeBeanData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "The Coffee Bean and Tea Leaf",
        //image: "The Coffee Bean",
        fixed_menu: ["The Coffee Bean and Tea Leaf Menu 1", "The Coffee Bean and Tea Leaf Menu 2", "The Coffee Bean and Tea Leaf Menu 3", "The Coffee Bean and Tea Leaf Menu 4"],
        sections: 4 ,
        section_names: ["Tea", "Espresso", "Ice Blended Drinks", "Coffee"]
    )
    let StarbucksData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Starbucks",
        //image: "The Coffee Bean",
        fixed_menu: ["Starbucks Menu"],
        sections: 1
    )
    let PandaExpressData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Panda Express",
        //image: "The Coffee Bean",
        fixed_menu: ["Panda Express Menu 1", "Panda Express Menu 2", "Panda Express Menu 3", "Panda Express Menu 4", "Panda Express Menu 5"],
        sections: 5 ,
        section_names: ["Main Menu", "Entree", "Sides", "Appetizers", "Drinks"]
    )
    let SubwayData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Subway",
        //image: "The Coffee Bean",
        fixed_menu: ["Subway Menu 1"],
        sections: 1
    )
    
    let output = [IvansatHinderakerData, BytesData,LollicupFreshBobaData,TheBarnData, HibachiSanJapaneseGrillData, ChronicTacosData, HabitData, HalalShackData, CoffeeBeanData,StarbucksData,PandaExpressData, SubwayData]
    return output
}
