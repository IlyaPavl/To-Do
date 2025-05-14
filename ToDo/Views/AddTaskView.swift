//
//  AddTaskView.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(TaskViewModel.self) private var viewModel
    
    @State private var title = ""
    @State private var priority = Task.Priority.medium
    
    @State private var dueDate = Date.now
    @State private var isDatePickerOn = false
    @State private var isDatePickerExpanded = false
    
    @State private var dueTime = Date.now
    @State private var isTimePickerOn = false
    @State private var isTimePickerExpanded = false
    @FocusState private var titleIsFocused: Bool
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Детали задачи")) {
                    TextField("Название задачи", text: $title)
                        .focused($titleIsFocused)
                        .onAppear {
                            titleIsFocused = true
                        }
                    
                    // Для даты
                    HStack {
                        Text("Дата")
                        Spacer()
                        Toggle("", isOn: $isDatePickerOn)
                            .labelsHidden()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isDatePickerOn {
                            withAnimation {
                                isDatePickerExpanded.toggle()
                            }
                        }
                    }
                    .onChange(of: isDatePickerOn) { oldValue, newValue in
                        if newValue == true {
                            isDatePickerExpanded = true
                        }
                    }

                    if isDatePickerOn && isDatePickerExpanded {
                        DatePicker("", selection: $dueDate, displayedComponents: [.date])
                            .datePickerStyle(.graphical)
                            .transition(.opacity)
                    }
                    
                    HStack {
                        Text("Время")
                        Spacer()
                        Toggle("", isOn: $isTimePickerOn)
                            .labelsHidden()
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if isTimePickerOn {
                            withAnimation {
                                isTimePickerExpanded.toggle()
                            }
                        }
                    }
                    .onChange(of: isTimePickerOn) { oldValue, newValue in
                        if newValue == true {
                            isTimePickerExpanded = true
                        }
                    }

                    if isTimePickerOn && isTimePickerExpanded {
                        DatePicker("", selection: $dueTime, displayedComponents: [.hourAndMinute])
                            .transition(.opacity)
                    }
                }
                
                Picker("Приоритет", selection: $priority) {
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
            }
            .navigationTitle("Новая задача")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Отмена") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Сохранить") {
                        viewModel.addTask(
                            title: title,
                            priority: priority,
                            dueDate: dueDate,
                            dueTime: dueTime
                        )
                        dismiss()
                    }
                    .disabled(title.isEmpty || !isDatePickerOn || !isTimePickerOn)
                }
            }
        }
    }
}
