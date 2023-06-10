//
//  PersistenceController.swift
//  Todo
//
//  Created by Mohamed Ali on 10/06/2023.
//

import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        for num in 0..<10 {
            let task = TaskItem(context: controller.container.viewContext)
            task.id = UUID()
            task.name = "task\(num)"
            task.priority = "Low"
        }
        return controller
    }()
    
    init(inMemory: Bool = false) {
        
        container = NSPersistentContainer(name: "Todo")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
