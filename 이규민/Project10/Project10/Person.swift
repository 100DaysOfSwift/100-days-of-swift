//
//  Person.swift
//  Project10
//
//  Created by 이규민 on 2023/10/31.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
