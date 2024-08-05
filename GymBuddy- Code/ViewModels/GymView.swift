//
//  GymView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftData
import SwiftUI

struct GymView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingAddWorkout = false
    @State private var edit = false
    let gym: Gym

    let types = ["All", "Push", "Pull", "Legs", "Other", "Cardio"]
    @State private var type = "All"

    var filteredWorkouts: [Workout] {
        if type == "All" {
            return gym.workouts.sorted(by: { $0.weight > $1.weight })
        } else {
            return gym.workouts.filter { $0.type.localizedCaseInsensitiveContains(type) }.sorted(by: { $0.weight > $1.weight })
        }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.4).edgesIgnoringSafeArea(.all) 
                
                VStack {
                    
                    if gym.workouts.isEmpty || filteredWorkouts.isEmpty {
                        Text("Tap the plus button in the top right to add your workouts!")
                            .bold()
                    }
                    
                    VStack {
                        Picker("Filter workouts by: ", selection: $type) {
                            ForEach(types, id: \.self) { type in
                                Text(type)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                        
                        List {
                            ForEach(filteredWorkouts, id: \.self) { lift in
                                NavigationLink {
                                    EditWorkoutView(workout: lift)
                                } label: {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(lift.name)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            Text("\(lift.sets)x\(lift.reps) \((lift.weight == 0) ? "Tap to add your weight!" : "\(lift.weight) lbs")")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        Spacer()
                                        Image(systemName: lift.weight == 0 ? "exclamationmark.circle" : "dumbbell.fill")
                                            .foregroundColor(lift.weight == 0 ? .red : .black)
                                    }
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .cornerRadius(10)
                                }
                            }
                            .onDelete(perform: deleteLifts)
                        }
                        .listStyle(InsetGroupedListStyle())
                    }
                }
            }
            .navigationTitle(gym.name)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showingAddWorkout) {
                AddWorkoutView(gym: gym)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddWorkout.toggle()
                    }) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
        }
    }

    func deleteLifts(at offsets: IndexSet) {
        let indicesToDelete = offsets.map { filteredWorkouts[$0].id }
        gym.workouts.removeAll { workout in
            indicesToDelete.contains(workout.id)
        }
    }
}
