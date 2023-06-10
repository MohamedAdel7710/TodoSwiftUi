//
//  TodoApp.swift
//  Todo
//
//  Created by Mohamed Ali on 09/06/2023.
//

import SwiftUI

@main
struct TodoApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
