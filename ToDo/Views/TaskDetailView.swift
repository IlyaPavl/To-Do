//
//  TaskDetailView.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct TaskDetailView: View {
    @Bindable var task: Task
    @Environment(TaskViewModel.self) private var viewModel
    
    var body: some View {
        Form {
            Section(header: Text("Информация о задаче")) {
                TextField("Название", text: $task.title)
                    .onChange(of: task.title) {
                        viewModel.updateTask(task)
                    }
                
                DatePicker("Дата и время", selection: $task.dueDate, displayedComponents: [.date, .hourAndMinute])
                    .onChange(of: task.dueDate) {
                        viewModel.updateTask(task)
                    }
                
                Picker("Приоритет", selection: $task.priority) {
                    ForEach(Task.Priority.allCases) { priority in
                        HStack {
                            Circle()
                                .fill(priority.color)
                                .frame(width: 12, height: 12)
                            Text(priority.rawValue)
                        }
                        .tag(priority)
                    }
                }
                .onChange(of: task.priority) {
                    viewModel.updateTask(task)
                }
                
                Toggle("Завершено", isOn: $task.isCompleted)
                    .onChange(of: task.isCompleted) {
                        viewModel.updateTask(task)
                    }
            }
        }
        .navigationTitle(task.title)
    }
}
