//
//  getUCLAfixed.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getUCDfixed() -> [Hall] {
    let CrepeBistroData = Hall(
        selectedKey: "ucddiningmenus",
        name: "Crepe Bistro",
        //image: "Crepe Bistro",
        fixed_menu: ["Crepe Bistro Menu"],
        sections: 1
    )

    
    let output = [CrepeBistroData]
    return output
}
