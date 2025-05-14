//
//  EmptyStateView.swift
//  To-Do
//
//  Created by Илья Павлов on 28.04.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        Image(systemName: imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 70, height: 70)
        Text(text)
            .multilineTextAlignment(.center)
            .font(.title2)
            .foregroundColor(.gray)
            .padding()
    }
}
