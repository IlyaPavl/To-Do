//
//  TaskRepository.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftData
import Foundation

protocol TaskRepositoryProtocol {
    func fetchTasks() -> [Task]
    func addTask(_ task: Task)
    func deleteTask(_ task: Task)
    func saveChanges() throws
    func reorderTasks(_ tasks: [Task])
}

final class TaskRepository: TaskRepositoryProtocol {
    private let modelContext: ModelContext
    private var cachedTasks: [Task]?
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchTasks() -> [Task] {
        if let cached = cachedTasks {
            return cached
        }
        
        let descriptor = FetchDescriptor<Task>()
        do {
            let tasks = try modelContext.fetch(descriptor)
            cachedTasks = tasks
            return tasks
        } catch {
            print("Ошибка при загрузке задач: \(error)")
            return []
        }
    }
    
    func addTask(_ task: Task) {
        modelContext.insert(task)
        cachedTasks = nil
    }
    
    func deleteTask(_ task: Task) {
        modelContext.delete(task)
        cachedTasks = nil
    }
    
    func reorderTasks(_ tasks: [Task]) {
        for (index, task) in tasks.enumerated() {
            task.order = index
        }
        cachedTasks = nil
    }
    
    func saveChanges() throws {
        try modelContext.save()
    }
}
