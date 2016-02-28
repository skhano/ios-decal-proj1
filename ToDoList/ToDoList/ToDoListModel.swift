//
//  ToDoListModel.swift
//  ToDoList
//
//  Created by Sam Khano on 2/27/16.
//  Copyright © 2016 samkhano. All rights reserved.
//

import UIKit

class ToDoListModel: NSObject {
    var tableEntries : [String]!
    
    override init() {
        tableEntries = [String]()
    }
    
    func addEntryToEndOfTable(label : String) {
        tableEntries.append(label)
    }
    
    func getEntryAtIndex(index : Int) -> String! {
        return tableEntries[index]
    }
    
    func getTableCount() -> Int {
        return tableEntries.count
    }
    
    func removeEntryAtIndex(index : Int) {
        tableEntries.removeAtIndex(index)
    }
    
    func contains(str : String) -> Bool {
        for elem in tableEntries {
            if (elem == str) {
                return true
            }
        }
        return false
    }
    
    func remove(str : String) {
        for (var i = 0; i < tableEntries.count; i++) {
            if (tableEntries[i] == str) {
                tableEntries.removeAtIndex(i)
                continue
            }
        }
    }
    
}
