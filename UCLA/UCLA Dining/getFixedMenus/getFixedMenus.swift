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
        output = getUCSBfixed()
    }
    else if (selectedKey == "ucddiningmenus") {
        output = getUCDfixed()
    }
    else if (selectedKey == "ucrdiningmenus") {
        output = getUCRfixed()
    }
    else if (selectedKey == "ucscdiningmenus") {
        output = getUCSCfixed()
    }
    else if (selectedKey == "ucbdiningmenus") {
        output = getUCBfixed()
    }
    else if (selectedKey == "utaustindiningmenus") {
        output = getUTAfixed()
    }
    
    return output
}
