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
        let BruinCafeData = Hall(
            name: "Bruin Cafe",
            image: "Bruin Cafe",
            fixed_menu: ["Bruin Cafe fixed menu 1", "Bruin Cafe fixed menu 2"],
            sections: 2,
            section_names: ["Lunch & Dinner", "Smoothies and Coffee"]
        )
        
        let EpicuriaAckermanData = Hall(
            name: "Epicuria at Ackerman",
            image: "Epicuria at Ackerman",
            fixed_menu: ["Ackerman fixed menu 1"],
            sections: 1
        )
        
        let DreyData = Hall(
            name: "The Drey",
            image: "the drey",
            fixed_menu: ["The Drey fixed menu 1"],
            sections: 1
        )
        
        let RendezvousData = Hall(
            name: "Rendezvous",
            image: "Rendezvous",
            fixed_menu: ["Rendezvous fixed menu 1", "Rendezvous fixed menu 2", "Rendezvous fixed menu 3"],
            sections: 3,
            section_names: ["West", "East", "Boba"]
        )
        
        let DeNeveLateNightData = Hall(
            name: "De Neve Late Night",
            image: "De Neve Late Night",
            fixed_menu: ["De Neve fixed menu 1"],
            sections: 1
        )
        
        let TheStudyatHedrickData = Hall(
            name: "The Study at Hedrick",
            image: "The Study at Hedrick",
            fixed_menu: ["Hedrick fixed menu 1", "Hedrick fixed menu 2", "Hedrick fixed menu 3", "Hedrick fixed menu 4", "Hedrick fixed menu 5"],
            sections: 5,
            section_names: ["Cafe Bakery", "Breakfast", "Lunch & Dinner", "Beverages", "Market"]
        )
        
        let SpiceKitchen = Hall(
            name: "The Spice Kitchen",
            image: "The Spice Kitchen",
            fixed_menu: ["Spice Kitchen fixed menu 1"],
            sections: 1
        )
        
        output = [BruinCafeData, EpicuriaAckermanData, DreyData, RendezvousData, DeNeveLateNightData, TheStudyatHedrickData, SpiceKitchen]
        
    }
    // return UCSB fixed restaurants
    else if (selectedKey == "ucsbdiningmenus") {
        
    }
    
    return output
}
