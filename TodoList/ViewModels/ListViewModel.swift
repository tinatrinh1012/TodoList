//
//  ListViewModel.swift
//  TodoList
//
//  Created by Tina Trinh on 5/21/24.
//

import Foundation

/*
 CRUD FUNCTIONS
 
 Create
 Read
 Update
 Delete
 
 */

// View Model: app data
// implements ObservableObject to observe this class from View
class ListViewModel: ObservableObject {
    
    // similar with @State in View
    // observable object
    // when changed, all views using this object will be reloaded to reflect those changes
    @Published var items: [ItemModel] = [] {
        didSet {
            // anytime items array changes, this function gets called
            saveItems()
        }
    }
    
    
    // need to store forKey in variable when need to pull data back from UserDefaults
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        // get saved items data from User Defaults
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
        
        
//        let newItems = [
//            ItemModel(title: "Item 1", isCompleted: false),
//            ItemModel(title: "Item 2", isCompleted: true),
//            ItemModel(title: "Item 3", isCompleted: false)
//        ]
//        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        
        // longer format
        // since firstIndex return optional Int, have to unwrap variable index
//        if let index = items.firstIndex(where: { currentItem in
//            return currentItem.id == item.id
//        }) {
//            // run this code
//        }
        
        // shorter format
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateCompletion()
        }
    }
    
    // User Defaults typically used for storing small data, like user name, user id
    // For typical app, we would store data in Core Data
    func saveItems() {
        // convert ItemModel to JSON data
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.setValue(encodedData, forKey: itemsKey)
        }
    }
}
