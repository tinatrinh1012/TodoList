//
//  ItemModel.swift
//  TodoList
//
//  Created by Tina Trinh on 5/20/24.
//

import Foundation

// Imutable Struct
// conform to Condable to transfer into and out of data
struct ItemModel: Identifiable, Codable {
    // these are constant variables and cannot be changed on the fly
    var id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    // object instance update must be through this function
    // make sure all logic in app that relate to updating this model is under this function 
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
