//
//  StreakView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/30/24.
//

import SwiftUI
import SwiftData

struct StreakView: View {
    let user: User
    var body: some View {
        HStack {
            VStack {
                StreakViewModel(streak: (user.streak[0] == 1), day: 0)
                Text("S")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[1] == 1), day: 1)
                Text("M")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[2] == 1), day: 2)
                Text("T")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[3] == 1), day: 3)
                Text("W")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[4] == 1), day: 4)
                Text("T")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[5] == 1), day: 5)
                Text("F")
                    .font(.system(size: 15))
            }
            VStack {
                StreakViewModel(streak: (user.streak[6] == 1), day: 6)
                Text("S")
                    .font(.system(size: 15))
            }
        }
        .padding()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
//        let gym = Gym(name: "AnyTime Fitness", location: "Cranberry", type: "Personal")
//        let gym2 = Gym(name: "The Pete", location: "Pittsburgh", type: "School")
        let user = User(firstname: "Aidan", lastname: "O'Hara", age: Date.now, height: [6:1], weight: 200.0)
        user.streak[1] = 1
       
        
        return StreakView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create prieview:  \(error.localizedDescription)")
    }
}
