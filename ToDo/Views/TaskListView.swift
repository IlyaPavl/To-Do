//
//  TaskListView.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct TaskListView: View {
    @Environment(TaskViewModel.self) private var viewModel
    let tasks: [Task]
    let filter: FilterOption
    
    var body: some View {
        List {
            ForEach(tasks, id: \.id) { task in
                NavigationLink(destination: TaskDetailView(task: task)) {
                    TaskRowView(task: task)
                }
            }
            .onDelete { offsets in
                viewModel.deleteTasks(at: offsets, from: tasks)
            }
            .if(filter == .active) { view in
                view.onMove { source, destination in
                    var reorderedTasks = tasks
                    reorderedTasks.move(fromOffsets: source, toOffset: destination)
                    viewModel.reorderTasks(reorderedTasks)
                }
            }
        }
        .listStyle(.insetGrouped)
    }
}
