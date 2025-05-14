//
//  Task.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//


import Foundation
import SwiftData
import SwiftUI

@Model
final class Task {
    var id: UUID
    var title: String
    var isCompleted: Bool
    var priorityRawValue: String
    var dueDate: Date
    var dueTime: Date
    var order: Int
    
    var priority: Priority {
        get { Priority(rawValue: priorityRawValue) ?? .medium }
        set { priorityRawValue = newValue.rawValue }
    }
    
    init(
        id: UUID = UUID(),
        title: String,
        isCompleted: Bool = false,
        priority: Priority = .medium,
        dueDate: Date,
        dueTime: Date,
        order: Int = 0
    ) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.priorityRawValue = priority.rawValue
        self.dueDate = dueDate
        self.dueTime = dueTime
        self.order = order
    }
    
    enum Priority: String, CaseIterable, Identifiable {
        case low = "Низкий"
        case medium = "Средний"
        case high = "Высокий"
        
        var id: String { self.rawValue }
        
        var color: Color {
            switch self {
            case .low: return .green
            case .medium: return .yellow
            case .high: return .red
            }
        }
    }
}
