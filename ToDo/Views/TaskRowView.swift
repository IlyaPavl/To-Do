//
//  TaskRowView.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct TaskRowView: View {
    @Bindable var task: Task
    @Environment(TaskViewModel.self) private var viewModel
    private var dueDateColor: Color {
        task.isCompleted ? .secondary : (task.dueDate < Date() ? .red : .secondary)
    }
    
    var body: some View {
        HStack {
            Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                .imageScale(.large)
                .foregroundColor(task.isCompleted ? .green : .gray)
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                    withAnimation {
                        viewModel.toggleTaskCompletion(task)
                    }
                }
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(task.title)
                    .font(.headline)
                    .opacity(task.isCompleted ? 0.5 : 1)
                
                Text(task.dueDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(dueDateColor)
                    .opacity(task.isCompleted ? 0.5 : 1)
            }
            Spacer()
            Circle()
                .fill(task.priority.color)
                .frame(width: 12, height: 12)
        }
    }
}
