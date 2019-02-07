//
//  Category.swift
//  Todoey
//
//  Created by Unprivileged on 2/6/19.
//  Copyright © 2019 Unprivileged. All rights reserved.
//

import Foundation
import RealmSwift


class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
