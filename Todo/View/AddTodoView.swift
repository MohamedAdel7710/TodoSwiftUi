//
//  AddTodoView.swift
//  Todo
//
//  Created by Mohamed Ali on 10/06/2023.
//

import SwiftUI

struct AddTodoView: View {
    //MARK: -  PROPERTY
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismissView
    
    @State private var taskName = ""
    @State private var priority = "Normal"
    @State private var isShowingAlert = false
    private let priorities = ["Low", "Normal", "High"]
    
    //MARK: - BODY
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 20) {
                    TextField("Todo", text: $taskName)
                    .padding()
                    .background(Color(UIColor.tertiarySystemFill))
                    .cornerRadius(10)
                    
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                    
                    Button {
                        guard taskName != "" else {
                            isShowingAlert.toggle()
                            return
                        }
                        saveTask(name: taskName, priority: priority)
                        
                    } label: {
                        Text("Save")
                          .font(.system(size: 24, weight: .bold))
                          .padding()
                          .frame(minWidth: 0, maxWidth: .infinity)
                          .background(.blue)
                          .cornerRadius(9)
                          .foregroundColor(Color.white)
                    }
                Spacer()
            }
            .padding(.vertical,20)
            .padding(.horizontal)//VStack
            
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Invalid Name"), message: Text("Make sure to enter something for\nthe new todo item."), dismissButton: .default(Text("Ok")))
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismissView()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }//Toolbar
            
            
        }//NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
    //MARK: - Helper Function
    func saveTask(name:String, priority: String) {
        let task = TaskItem(context: managedObjectContext)
        task.name = name
        task.priority = priority
     
        do {
            try managedObjectContext.save()
            dismissView()
        } catch {
            print(error)
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
