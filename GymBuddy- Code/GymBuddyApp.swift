//
//  GymBuddyApp.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//


import SwiftUI
import SwiftData

@main
struct GymBuddyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [User.self, Log.self])
    }
}

