//
//  ContentView.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(TaskViewModel.self) private var viewModel
    @Query(sort: \Task.order) private var tasks: [Task]
    @State private var filter: FilterOption = .active
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    ErrorView(message: errorMessage)
                } else {
                    FilterPicker(filter: $filter)
                    TaskListSection(tasks: tasks, filter: filter)
                }
            }
            .navigationTitle("Задачи")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .disabled(tasks.isEmpty)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        showingAddTask = true
                    } label: {
                        HStack() {
                            Image(systemName: "plus.circle.fill")
                            Text("Новая задача")
                        }
                    }
                }
            }
            .sheet(isPresented: $showingAddTask) {
                AddTaskView()
            }
        }
    }
}
