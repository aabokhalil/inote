//
//  Item.swift
//  inote
//
//  Created by ahmed abokhalil on 7/28/1440 AH.
//  Copyright © 1440 AH ahmed abokhalil. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateCreated : Data?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    // inverse relationship links each item back to parent category
}
