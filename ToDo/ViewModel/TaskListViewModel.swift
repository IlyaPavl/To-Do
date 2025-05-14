//
//  TaskListViewModel.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI
import SwiftData

protocol TaskHandlingProtocol {
    func addTask(title: String, priority: Task.Priority, dueDate: Date, dueTime: Date)
    func updateTask(_ task: Task)
    func toggleTaskCompletion(_ task: Task)
    func deleteTasks(at offsets: IndexSet, from tasks: [Task])
    func reorderTasks(_ tasks: [Task])
}

enum FilterOption: String, CaseIterable, Identifiable {
    case active = "Активные"
    case completed = "Завершенные"
    case all = "Все"
    
    var id: String { self.rawValue }
}

@Observable
class TaskViewModel {
    private let repository: TaskRepositoryProtocol
    private let filterService: TaskFiltering
    var errorMessage: String?
    
    init(repository: TaskRepositoryProtocol, filterService: TaskFiltering) {
        self.repository = repository
        self.filterService = filterService
    }
    
    // MARK: - TaskFiltering
    func filteredTasks(_ tasks: [Task], by filter: FilterOption) -> [Task] {
        return filterService.filter(tasks: tasks, by: filter)
    }
    
    // MARK: - Private
    private func saveChanges() {
        do {
            try repository.saveChanges()
            errorMessage = nil
        } catch {
            errorMessage = "Ошибка сохранения: \(error.localizedDescription)"
        }
    }
}

extension TaskViewModel: TaskHandlingProtocol {
    func addTask(title: String, priority: Task.Priority, dueDate: Date, dueTime: Date) {
        let newTask = Task(title: title, priority: priority, dueDate: dueDate, dueTime: dueTime)
        repository.addTask(newTask)
        saveChanges()
    }
    
    func updateTask(_ task: Task) {
        saveChanges()
    }
    
    func toggleTaskCompletion(_ task: Task) {
        task.isCompleted.toggle()
        saveChanges()
    }
    
    func deleteTasks(at offsets: IndexSet, from tasks: [Task]) {
        for index in offsets {
            repository.deleteTask(tasks[index])
        }
        saveChanges()
    }
    
    func reorderTasks(_ tasks: [Task]) {
        repository.reorderTasks(tasks)
        saveChanges()
    }
}
