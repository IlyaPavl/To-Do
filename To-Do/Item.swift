//
//  Item.swift
//  To-Do
//
//  Created by Илья Павлов on 25.04.2025.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
