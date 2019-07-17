//
//  MyToDo.swift
//  MasterList
//
//  Created by Zakeel Muhammad on 7/16/19.
//  Copyright © 2019 Zakeel Muhammad. All rights reserved.
//

import Foundation
import AppCenterData

class ToDoItem : NSObject, MSSerializableDocument {
    
    var title: String
    var isDone: Bool
    var tid : String
    
    init(title: String) {
        self.title = title
        self.isDone = false
        self.tid = UUID.init().uuidString
    }
    
    required init(from dictionary: [AnyHashable : Any]) {
        self.title = dictionary["title"] as! String
        self.isDone = dictionary["isDone"] as! Bool
        self.tid = dictionary["tid"] as! String
        
    }
    
    func serializeToDictionary() -> [AnyHashable : Any] {
        return [
            "title" : self.title,
            "isDone" : self.isDone,
            "tid" : self.tid
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
