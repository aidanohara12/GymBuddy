//
//  StreakViewModel.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/30/24.
//

import SwiftUI

struct StreakViewModel: View {
    let streak: Bool
    let day: Int
    
    var body: some View {
        let date = Date()
        ZStack {
            Circle()
                .foregroundStyle(.gray.opacity(0.4))
            Image(systemName: streak ? "flame" : (day > dayOfWeek(for: date)!) ? "moon.fill" : "snowflake" )
                .foregroundColor(streak ? .orange : (day > dayOfWeek(for: date)!) ? .gray : .blue)
        }
    }
    func dayOfWeek(for date: Date) -> Int? {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: date)
        return component - 1
    }
}

#Preview {
    StreakViewModel(streak: true, day: 1)
}
