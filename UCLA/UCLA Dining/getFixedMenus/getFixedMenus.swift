//
//  getFixedMenus.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 1/17/23.
//

import Foundation

func getFixedMenus(selectedKey: String) -> [Hall] {
    var output : [Hall] = []
    
    // return UCLA fixed restaurants
    if (selectedKey == "diningmenus") {
        output = getUCLAfixed()
    }
    // return UCSB fixed restaurants
    else if (selectedKey == "ucsbdiningmenus") {
        //output = getUCSBfixed()
    }
    
    return output
}
