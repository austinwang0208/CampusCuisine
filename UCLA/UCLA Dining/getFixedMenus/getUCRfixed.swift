//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCRfixed() -> [Hall] {
    let IvansCoffeeShopData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Ivan's Coffee Shop",
        //image: "Ivan's Coffee Shop",
        fixed_menu: ["Ivan's Coffee Shop"],
        sections: 1
    )
    
    let BytesCafeData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Bytes Cafe",
        //image: "Bytes Cafe",
        fixed_menu: ["Bytes Cafe"],
        sections: 1
    )
    let LollicupFreshBobaData = Hall(
        selectedKey: "ucrdiningmenus",
        name: "Lollicup Fresh Boba",
        //image: "Lollicup Fresh Boba",
        fixed_menu: ["Lollicup Fresh Boba"],
        sections: 1
    )

    
    let output = [IvansCoffeeShopData, BytesCafeData, LollicupFreshBobaData]
    return output
}
