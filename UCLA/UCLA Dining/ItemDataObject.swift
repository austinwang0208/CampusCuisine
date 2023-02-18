//
//  ItemDataObject.swift
//  UCLA Dining
//
//  Created by Austin Wang on 2/15/23.
//

import Foundation

struct ItemDataObject: Identifiable {
    let id = UUID()
    var food = ""
    var mealtime = ""
    var hallname = ""

 

}

extension ItemDataObject {
    static func mock() -> ItemDataObject {
        ItemDataObject(food: "pizza", mealtime: "lunch", hallname: "crown")
    }
}
