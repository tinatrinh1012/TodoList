//
//  TodoListApp.swift
//  TodoList
//
//  Created by Tina Trinh on 5/20/24.
//

import SwiftUI

/* MVVM Architecture
 
 Model - data point
 View - UI
 ViewModel - manages Models for View
 
 */

@main
struct TodoListApp: App {
    // if this variable changes, our app will change
    @StateObject var listViewModel: ListViewModel = ListViewModel()
    
    // To create App Icon: Use canva to create the largest size square image possible
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ListView()
            }
            .navigationViewStyle(.stack)
            .environmentObject(listViewModel)
        }
    }
}
