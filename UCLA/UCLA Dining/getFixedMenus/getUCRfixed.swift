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
        //image: "Bytes Cafe",
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

    
    let output = [IvansatHinderaker, BytesData,LollicupFreshBobaData]
    return output
}
