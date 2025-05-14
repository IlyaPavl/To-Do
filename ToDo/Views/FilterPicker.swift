//
//  FilterPicker.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUI

struct FilterPicker: View {
    @Binding var filter: FilterOption
    @Environment(\.editMode) private var editMode
    
    var isEditing: Bool {
        editMode?.wrappedValue.isEditing == true
    }
    
    var body: some View {
        Picker("Фильтр", selection: $filter) {
            ForEach(FilterOption.allCases) { option in
                Text(option.rawValue)
                    .tag(option)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        .disabled(isEditing)
    }
}
