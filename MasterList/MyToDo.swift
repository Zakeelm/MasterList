//
//  MyToDo.swift
//  MasterList
//
//  Created by Zakeel Muhammad on 7/16/19.
//  Copyright © 2019 Zakeel Muhammad. All rights reserved.
//

import Foundation

class ToDoItem {
    var title: String
    var isDone: Bool
    
    init(title: String) {
        self.title = title
        self.isDone = false
    }
}

extension ToDoItem {
    
    public class func getMockData() -> [ToDoItem]
    {
        return [
            ToDoItem(title: "Milk"),
            ToDoItem(title: "Chocolate"),
            ToDoItem(title: "Light bulb"),
            ToDoItem(title: "Dog food")
        ]
    }
}
