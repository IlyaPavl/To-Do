//
//  TaskFilterService.swift
//  To-Do
//
//  Created by Илья Павлов on 28.04.2025.
//

import Foundation

protocol TaskFiltering {
    func filter(tasks: [Task], by filter: FilterOption) -> [Task]
}

final class TaskFilterService: TaskFiltering {
    func filter(tasks: [Task], by filter: FilterOption) -> [Task] {
        switch filter {
        case .all:
            return tasks
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .active:
            return tasks.filter { !$0.isCompleted }
        }
    }
}
