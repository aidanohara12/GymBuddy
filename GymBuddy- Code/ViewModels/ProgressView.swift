//
//  ProgressView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI

struct ProgressView: View {
    @Binding var progress: Int
    var color: Color
    var goal: Int
    private let width: CGFloat = 10
    var body: some View {
        ZStack {
            Circle()
                .stroke(color.opacity(0.3), lineWidth: width)
            
            Circle()
                .trim(from: 0, to: CGFloat(progress) / CGFloat(goal))
                .stroke(color, style: StrokeStyle(lineWidth: width, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .shadow(radius: 5)
        }
        .frame(width: 100, height: 100)
    }
}

#Preview {
    ProgressView(progress: .constant(200), color: .red, goal: 300)
}

