//
//  AddView.swift
//  TodoList
//
//  Created by Tina Trinh on 5/20/24.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Add todo item", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button (action: saveItem, label: {
                    Text("Save".uppercased())
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })

            }
            .padding(14)
        }
        .navigationTitle("Add Item 🖊️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveItem() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            
            // tell presentation mode to go back 1 in the view hierachy
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "New todo item must be at least 3 characters long 🫣"
            showAlert = true
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                AddView()
            }
            .environmentObject(ListViewModel())
            .preferredColorScheme(.light)
            
            NavigationView {
                AddView()
            }
            .environmentObject(ListViewModel())
            // do this so you don't have to switch between light and dark mode
            .preferredColorScheme(.dark)
        }
    }
}
