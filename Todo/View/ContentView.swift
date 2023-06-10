//
//  ContentView.swift
//  Todo
//
//  Created by Mohamed Ali on 09/06/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.priority)
    ]) var items: FetchedResults<TaskItem>
    
    @State private var showingAddTodo = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self){ item in
                    let name = item.name
                    Text("\(name ?? "")")
                }
                .onDelete(perform: deleteItems)
            }
            
            .navigationTitle("Todo List")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddTodo, content: {
                AddTodoView().environment(\.managedObjectContext, self.viewContext)
            })
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.showingAddTodo.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
        
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
