//
//  ContentView.swift
//  Todo
//
//  Created by Mohamed Ali on 09/06/2023.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.name),
        SortDescriptor(\.priority)
    ]) var items: FetchedResults<TaskItem>
    
    @State private var showingAddTodo = false
    @State private var showingSetting = false
    
    let themes = themeData
    @ObservedObject var theme = ThemeSettings.shared
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(items, id: \.self){ item in
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.accentColor)
                            Text("\(item.name?.capitalized ?? "")")
                                .fontWeight(.bold)
                            Spacer()
                            Text("\(item.priority ?? "")")
                                .font(.footnote)
                                .foregroundColor(Color(UIColor.systemGray2))
                                .padding(3)
                                .frame(minWidth: 62)
                                .overlay(
                                    Capsule().stroke(Color(UIColor.systemGray2), lineWidth: 0.75)
                                )
                                
                        }
                        .padding(.vertical)
                        
                        
                    }
                    .onDelete(perform: deleteItems)
                } // LIST
                
                .navigationTitle("Todo List")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showingAddTodo, content: {
                    AddTodoView().environment(\.managedObjectContext, self.viewContext)
                })
                .sheet(isPresented: $showingSetting, content: {
                    SettingView()
                })
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            self.showingSetting.toggle()
                        } label: {
                            Image(systemName: "gearshape")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }// TOOLBAR
                
                if items.count == 0 {
                    EmptyView()
                }
            }
            .overlay(
                ZStack {
                    Circle()
                        .frame(width: 68, height: 68, alignment: .center)
                        .foregroundColor(.accentColor)
                        .opacity(0.2)
                    
                    Circle()
                        .frame(width: 88, height: 88, alignment: .center)
                        .foregroundColor(.accentColor)
                        .opacity(0.15)
                    
                    Button {
                        showingAddTodo.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                          .resizable()
                          .scaledToFit()
                          .background(Circle().fill(Color("ColorBase")))
                          .frame(width: 48, height: 48, alignment: .center)
                    }
                }
                    .padding(.horizontal, 20)
                    .padding(.bottom)
                ,alignment: .bottomTrailing
            )
        }
        .navigationViewStyle(.stack)
        .accentColor(themes[self.theme.themeSettings].color)
        
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
        HomeView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
