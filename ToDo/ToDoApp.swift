//
//  ToDoApp.swift
//  ToDo
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI
import SwiftData

@main
struct ToDoApp: App {
    let sharedModelContainer: ModelContainer
    let repository: TaskRepository
    let taskViewModel: TaskViewModel
    let filterService: TaskFiltering
    
    init() {
        let schema = Schema([Task.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        
        do {
            sharedModelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            repository = TaskRepository(modelContext: sharedModelContainer.mainContext)
            filterService = TaskFilterService()
            taskViewModel = TaskViewModel(repository: repository, filterService: filterService)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.modelContext, sharedModelContainer.mainContext)
                .environment(taskViewModel)
        }
        .modelContainer(sharedModelContainer)
    }
}
