//
//  Category.swift
//  inote
//
//  Created by ahmed abokhalil on 7/28/1440 AH.
//  Copyright © 1440 AH ahmed abokhalil. All rights reserved.
//

import Foundation
import RealmSwift

import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
    // relationship specifies each category can have anumber of items , list of Item object
}
