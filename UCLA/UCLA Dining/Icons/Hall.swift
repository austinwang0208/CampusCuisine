//
//  HallStruct.swift
//  UCLA Dining
//
//  Created by Rohan Sehgal on 10/19/22.
//

import Foundation
import UIKit

struct Hall: Hashable {
    var selectedKey: String
    var name: String
    var dishes: [String : [String]]?
//    var image = String
    var image: UIImage? {
        return getImageFromFileManager()
    }
    var fixed_menu: [String]?
    var sections: Int?
    var section_names: [String]?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Hall, rhs: Hall) -> Bool {
        return lhs.name == rhs.name
    }
    
    func getImageFromFileManager() -> UIImage?{
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let directory2 = directory?.appendingPathComponent("\(selectedKey)/")
        let newkey = name.replacingOccurrences(of: " ", with: "_")
        //let test_path = directory?.appendingPathComponent("\(newkey).jpg")
        //print(test_path)
        guard
            let path = directory2?.appendingPathComponent("\(newkey).jpg"),
            FileManager.default.fileExists(atPath: path.path) else{
            return nil
        }
        
        return UIImage(contentsOfFile: path.path)
    }
    
}
