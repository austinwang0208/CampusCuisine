//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCRfixed() -> [Hall] {
    let IvansatHinderaker = Hall(
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
    let HibachiSanJapaneseGrill = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Hibachi-San Japanese Grill",
        //image: "Hibachi San Japanese Grill",
        fixed_menu: ["Hibachi-San Japanese Grill Menu 1"],
        sections: 1
    )

    
    let output = [IvansatHinderaker, BytesData,LollicupFreshBobaData,TheBarnData, HibachiSanJapaneseGrill]
    return output
}
