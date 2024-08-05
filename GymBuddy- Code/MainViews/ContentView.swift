//
//  ContentView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var users: [User]
    
    var body: some View {
        if users.isEmpty {
            LoadingView()
        }
        else {
            TabView {
                UserGymView(user: users.first!)
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                UserLogView(user: users.first!)
                    .tabItem {
                        Label("Log Workout", systemImage: "pencil.and.list.clipboard")
                            .foregroundColor(.black)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .onAppear(perform: {
                        let date = Date()
                        if dayOfWeek(for: date) == 0 && users.first!.sundayInput == false{
                            users.first!.streak = [0 , 0 , 0 , 0 , 0 , 0 , 0]
                        }
                        if dayOfWeek(for: date) != 0 {
                            users.first!.sundayInput = false
                        }
                    })
                UserFitnessView(user: users.first!)
                    .tabItem {
                        Label("View Workouts", systemImage: "figure.run.circle.fill")
                            .foregroundColor(.black)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                UserHealthDataView(user: users.first!)
                    .tabItem {
                        Label("User Data", systemImage: "stethoscope.circle.fill")
                            .foregroundColor(.black)
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    
            }
            .tint(.blue)
            .background(.blue.opacity(0.4))
            
        }
    }
    func dayOfWeek(for date: Date) -> Int? {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: date)
        return component - 1
    }
}

#Preview {
    ContentView()
}
