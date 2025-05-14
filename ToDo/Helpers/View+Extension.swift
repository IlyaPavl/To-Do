//
//  View+Extension.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import SwiftUICore

extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
