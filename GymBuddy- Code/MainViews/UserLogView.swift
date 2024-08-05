//
//  UserLogView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData



struct UserLogView: View {
    let user: User

    @State private var addLog = false
    var body: some View {
        NavigationStack {
            StreakView(user: user)
            Text(userHasStreak() ? "Keep your streak up!" : "Start your streak today and add a log!")
                .font(.caption)
            Text("Current Streak: \(user.continuusStreak)")
                
            List {
                Section(user.logs.isEmpty ? "Press the plus button to add a log!" : "Users logs") {
                    ForEach(user.logs.sorted(by: { $0.date > $1.date })) { log in
                        NavigationLink(destination: LogView(log: log)) {
                            VStack {
                                Text("\(user.firstname)'s workout on \(log.date.formatWorkoutDate())")
                                    .bold()
                                HStack {
                                    Text("\(log.intensity) intensity")
                                    Spacer()
                                    Text(log.workouts.isEmpty && log.restDay ? "Rest Day" : "^[\(log.workouts.count) Workouts](inflect: true) Done")
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteLogs)
                }
                
            }
            .listStyle(.insetGrouped)
            .background(.blue.opacity(0.4))
            .scrollContentBackground(.hidden)
            .navigationTitle("\(user.firstname)'s Workout Logs")
            .toolbar {
                Button("Plus", systemImage: "plus") {
                    addLog.toggle()
                }
            }
            .sheet(isPresented: $addLog) {
                AddLogView(user: user)
            }
        }
    }
    
    func userHasStreak() -> Bool {
        let date = Date()
        if dayOfWeek(for: date) != 0 {
            if (user.streak[dayOfWeek(for: date)!] == 1) && (user.streak[dayOfWeek(for: date)! - 1] == 1) {
                return true
            }
        }
        return false
    }
    
    func dayOfWeek(for date: Date) -> Int? {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: date)
        return component - 1
    }
    
    func deleteLogs(at offsets: IndexSet) {
        for offset in offsets {
            user.logs.remove(at: offset)
        }
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
        user.streak[2] = 1
        
        return UserLogView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create prieview:  \(error.localizedDescription)")
    }
}

