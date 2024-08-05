//
//  AddNewWorkoutView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 8/4/24.
//

import SwiftUI

struct AddNewWorkoutView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let gym: Gym
    
    @State private var name = ""
    @State private var weight = ""
    @State private var type = "Push"
    @State private var set = 3
    @State private var rep = 12
    
    
    
    
    let sets = [1,2,3,4,5]
    let types = ["Push", "Pull", "Legs", "Other", "Cardio"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.4).ignoresSafeArea()
                Form {
                    Section {
                        TextField("Workout Name:", text: $name)
                    }
                    Section {
                        Picker("What type of workout is this", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section {
                        Stepper("\(set) sets", value: $set, in: 1...5)
                        Stepper("\(rep) reps", value: $rep, in: 4...15)
                    }
                    Section {
                        Button("Save Button") {
                            let workout = Workout(id: Int.random(in: 100...1000), name: name, type: type, weight: 0, weights: [:],sets: set, reps: rep, isAdded: true )
                            gym.workouts.append(workout)
                            dismiss()
                        }
                        .disabled(name.isEmpty)
                    }
                }
            }
            
            .navigationTitle("Add New User Workout")
            .scrollBounceBehavior(.basedOnSize)
        }
        .scrollContentBackground(.hidden)
    }
}
