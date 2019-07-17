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
    
    required init(from dictionary: [AnyHashable : Any]) {
        self.title = dictionary["title"] as! String
        self.isDone = dictionary["isDone"] as! Bool
        
    }
    
    func serializeToDictionary() -> [AnyHashable : Any] {
        return [
            "title" : self.title,
            "isDone" : self.isDone
        ]
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
