//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCLAfixed() -> [Hall] {
    let BruinCafeData = Hall(
        selectedKey: "diningmenus",
        name: "Bruin Cafe",
        //image: "Bruin Cafe",
        fixed_menu: ["Bruin Cafe fixed menu 1", "Bruin Cafe fixed menu 2"],
        sections: 2,
        section_names: ["Lunch & Dinner", "Smoothies and Coffee"]
    )
    
    let EpicuriaAckermanData = Hall(
        selectedKey: "diningmenus",
        name: "Epicuria at Ackerman",
        //image: "Epicuria at Ackerman",
        fixed_menu: ["Ackerman fixed menu 1"],
        sections: 1
    )
    
    let DreyData = Hall(
        selectedKey: "diningmenus",
        name: "The Drey",
        //image: "the drey",
        fixed_menu: ["The Drey fixed menu 1"],
        sections: 1
    )
    
    let RendezvousData = Hall(
        selectedKey: "diningmenus",
        name: "Rendezvous",
        //image: "Rendezvous",
        fixed_menu: ["Rendezvous fixed menu 1", "Rendezvous fixed menu 2", "Rendezvous fixed menu 3"],
        sections: 3,
        section_names: ["West", "East", "Boba"]
    )
    
    let DeNeveLateNightData = Hall(
        selectedKey: "diningmenus",
        name: "De Neve Late Night",
        //image: "De Neve Late Night",
        fixed_menu: ["De Neve fixed menu 1"],
        sections: 1
    )
    
    let TheStudyatHedrickData = Hall(
        selectedKey: "diningmenus",
        name: "The Study at Hedrick",
        //image: "The Study at Hedrick",
        fixed_menu: ["Hedrick fixed menu 1", "Hedrick fixed menu 2", "Hedrick fixed menu 3", "Hedrick fixed menu 4", "Hedrick fixed menu 5"],
        sections: 5,
        section_names: ["Cafe Bakery", "Breakfast", "Lunch & Dinner", "Beverages", "Market"]
    )
    
    let SpiceKitchen = Hall(
        selectedKey: "diningmenus",
        name: "The Spice Kitchen",
        //image: "The Spice Kitchen",
        fixed_menu: ["Spice Kitchen fixed menu 1"],
        sections: 1
    )
    
    let BurgerAssembly = Hall(
        selectedKey: "diningmenus",
        name: "Burger Assembly",
        //image: "Burger Assembly",
        fixed_menu: ["Burger Assembly fixed menu 1"],
        sections: 1
    )
    
    let EpazoteMexicanGrill = Hall(
        selectedKey: "diningmenus",
        name: "Epazote Mexican Grill",
        //image: "Epazote Mexican Grill",
        fixed_menu: ["Epazote Mexican Grill fixed menu 1"],
        sections: 1
    )
    
    let Tossed = Hall(
        selectedKey: "diningmenus",
        name: "Tossed",
        //image: "Tossed",
        fixed_menu: ["Tossed fixed menu 1"],
        sections: 1
    )
    
    let Fusion = Hall(
        selectedKey: "diningmenus",
        name : "Fusion",
        //image: "Fusion",
        fixed_menu: ["Fusion fixed menu 1"],
        sections: 1
    )
    let JimmyData = Hall(
        selectedKey: "diningmenus",
        name : "Jimmy's",
        //image: "Fusion",
        fixed_menu: ["Jimmy's menu 1"],
        sections: 1
    )
    let AndersonData = Hall(
        selectedKey: "diningmenus",
        name : "Anderson Cafe",
        //image: "Fusion",
        fixed_menu: ["Anderson Cafe Menu 1"],
        sections: 1
    )
    let NorthernData = Hall(
        selectedKey: "diningmenus",
        name : "Northern Lights",
        //image: "Fusion",
        fixed_menu: ["Northern Lights Menu 1"],
        sections: 1
    )
    let PizzaFrescaData = Hall(
        selectedKey: "diningmenus",
        name : "Pizza Fresca",
        //image: "Fusion",
        fixed_menu: ["Pizza Fresca Menu 1"],
        sections: 1
    )
    let SouthernLightsData = Hall(
        selectedKey: "diningmenus",
        name : "Southern Lights",
        //image: "Fusion",
        fixed_menu: ["Southern Lights Menu 1"],
        sections: 1
    )
    
    let YoshinoyaData = Hall(
        selectedKey: "diningmenus",
        name: "Yoshinoya",
        //image: "The Coffee Bean",
        fixed_menu: ["Yoshinoya Menu 1"],
        sections: 1
    )
    let SynapseData = Hall(
        selectedKey: "diningmenus",
        name: "Cafe Synapse",
        //image: "The Coffee Bean",
        fixed_menu: ["Cafe Synapse Menu 1"],
        sections: 1
    )
    let PlateiaData = Hall(
        selectedKey: "diningmenus",
        name: "Plateia",
        //image: "The Coffee Bean",
        fixed_menu: ["Plateia Menu 1", "Plateia Menu 2","Plateia Menu 3","Plateia Menu 4", "Plateia Menu 5","Plateia Menu 6"],
        sections: 6,
        section_names: ["Breakfast", "Brunch", "Lunch", "Dinner","Drinks","Lounge"]

    )
    let TacoBellData = Hall(
        selectedKey: "diningmenus",
        name: "Taco Bell",
        //image: "The Coffee Bean",
        fixed_menu: ["Taco Bell Menu 1", "Taco Bell Menu 2","Taco Bell Menu 3","Taco Bell Menu 4", "Taco Bell Menu 5","Taco Bell Menu 6","Taco Bell Menu 7"],
        sections: 7,
        section_names: ["Combos", "Sides", "Drinks", "Breakfast","Sauces","Veggie Meals", "Group Menu"]

    )
    let WetzelsData = Hall(
        selectedKey: "diningmenus",
        name: "Wetzel's Pretzels",
        //image: "The Coffee Bean",
        fixed_menu: ["Wetzel's Menu 1"],
        sections: 1
    )
    let CarlsData = Hall(
        selectedKey: "diningmenus",
        name: "Carl's Junior",
        //image: "The Coffee Bean",
        fixed_menu: ["Carl's Junior Menu 1", "Carl's Junior Menu 2","Carl's Junior Menu 3","Carl's Junior Menu 4", "Carl's Junior Menu 5","Carl's Junior Menu 6"],
        sections: 6,
        section_names: ["Breakfast", "Chicken", "Charbroiled", "Beverages","KidsMenu","Sides and Desserts"]
    )
    let MusicCafeData = Hall(
        selectedKey: "diningmenus",
        name: "Music Cafe",
        //image: "The Coffee Bean",
        fixed_menu: ["Music Cafe Menu 1"],
        sections: 1
    )
    let KerckhoffData = Hall(
        selectedKey: "diningmenus",
        name: "Kerckhoff Coffee House",
        //image: "The Coffee Bean",
        fixed_menu: ["Kerckhoff Coffee House Menu 1"],
        sections: 1
    )
    let LollicupData = Hall(
        selectedKey: "diningmenus",
        name: "Lollicup Express",
        //image: "The Coffee Bean",
        fixed_menu: ["Lollicup Express Menu 1"],
        sections: 1
    )
    let PandaExpressData = Hall(
        selectedKey: "diningmenus",
        name: "Panda Express",
        //image: "The Coffee Bean",
        fixed_menu: ["Panda Express Menu 1", "Panda Express Menu 2", "Panda Express Menu 3", "Panda Express Menu 4", "Panda Express Menu 5"],
        sections: 5 ,
        section_names: ["Main Menu", "Entree", "Sides", "Appetizers", "Drinks"]
    )
    let VeggieGrillData = Hall(
        selectedKey: "diningmenus",
        name: "Veggie Grill",
        //image: "The Coffee Bean",
        fixed_menu: ["Veggie Grill Menu 1"],
        sections: 1
    )
    let RubiosData = Hall(
        selectedKey: "diningmenus",
        name: "Rubios",
        //image: "The Coffee Bean",
        fixed_menu: ["Rubios Menu 1"],
        sections: 1
    )

    
    let output = [BruinCafeData, EpicuriaAckermanData, DreyData, RendezvousData, DeNeveLateNightData, TheStudyatHedrickData, SpiceKitchen, BurgerAssembly, EpazoteMexicanGrill, Tossed, Fusion, JimmyData, AndersonData, NorthernData, PizzaFrescaData, SouthernLightsData, YoshinoyaData,SynapseData, PlateiaData, TacoBellData,WetzelsData, CarlsData, MusicCafeData,KerckhoffData, LollicupData, PandaExpressData, VeggieGrillData, RubiosData]
    return output
}
