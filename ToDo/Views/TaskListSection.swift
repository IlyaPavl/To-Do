//
//  TaskListSection.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct TaskListSection: View {
    @Environment(TaskViewModel.self) private var viewModel
    let tasks: [Task]
    let filter: FilterOption
    
    var body: some View {
        let filteredTasks = viewModel.filteredTasks(tasks, by: filter)
        VStack {
            if filteredTasks.isEmpty {
                Spacer()
                EmptyStateView(text: "Нет доступных для отображения задач", imageName: "list.bullet.rectangle")
                Spacer()
            } else {
                TaskListView(tasks: filteredTasks, filter: filter)
            }
        }
    }
}
