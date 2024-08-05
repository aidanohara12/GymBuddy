//
//  AddLogWorkoutView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/30/24.
//

import SwiftUI
import SwiftData

struct AddLogWorkoutView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Binding var selectedWorkouts: [Workout]
    
    let workoutTypes = [
        // Push workouts
        Workout(id: 0, name: "Bench Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 1, name: "Smith Machine Incline", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 2, name: "Incline Bench Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 3, name: "Decline Bench Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 4, name: "Shoulder Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 5, name: "Arnold Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 6, name: "Dumbbell Flyes", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 7, name: "Cable Flyes", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 8, name: "Pec Deck Flyes", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 9, name: "Chest Dips", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 10, name: "Tricep Dips", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 11, name: "Overhead Tricep Extension", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 12, name: "Skull Crushers", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 13, name: "Tricep Pushdown", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 14, name: "Rope Pulldown", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 15, name: "Overhead Rope Pulldown", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 16, name: "Close-Grip Bench Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 17, name: "Shoulder Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 18, name: "Cable Lateral Raise", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 19, name: "Lateral Raise", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 20, name: "Machine Shoulder Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 21, name: "Reverse Grip Bench Press", type: "Push", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),

        // Pull workouts
        Workout(id: 22, name: "Pull-Ups", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 23, name: "Chin-Ups", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 24, name: "Lat Pulldown", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 25, name: "Bent Over Row", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 26, name: "T-Bar Row", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 27, name: "Single-Arm Dumbbell Row", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 28, name: "Seated Row", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 29, name: "Face Pull", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 30, name: "Rear Delt Fly", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 31, name: "Reverse Fly", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 32, name: "Hammer Curl", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 33, name: "Bicep Curl", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 34, name: "Concentration Curl", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 35, name: "Preacher Curl", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 36, name: "Cable Curl", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 37, name: "Lat Pullovers", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 38, name: "Reverse Grip Bent Over Row", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 39, name: "Seated Bent Over Rear Delt Raise", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 40, name: "Standing Pulldown", type: "Pull", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),

        // Leg workouts
        Workout(id: 41, name: "Squat", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 42, name: "Leg Press", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 43, name: "Leg Press (single leg)", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 44, name: "Lunges", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 45, name: "Leg Extension", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 46, name: "Leg Curl", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 47, name: "Calf Raise", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 48, name: "Deadlift", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 49, name: "Romanian Deadlift", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 50, name: "Sumo Deadlift", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 51, name: "Bulgarian Split Squat", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 52, name: "Step-Up", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 53, name: "Hip Thrust", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 54, name: "Glute Bridge", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 55, name: "Hamstring Curl", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 56, name: "Adductor Machine", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 57, name: "Leg Press", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 58, name: "Sissy Squat", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 59, name: "Standing Calf Raise", type: "Legs", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),

        // Other workouts
        Workout(id: 60, name: "Crunch Machine", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 61, name: "Obliques", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 62, name: "Plank", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 60, isAdded: false),
        Workout(id: 63, name: "Mountain Climbers", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 30, isAdded: false),
        Workout(id: 64, name: "Bicycle Crunches", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 20, isAdded: false),
        Workout(id: 65, name: "Russian Twists", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 40, isAdded: false),
        Workout(id: 66, name: "Leg Raises", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 15, isAdded: false),
        Workout(id: 67, name: "Side Plank", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 30, isAdded: false),
        Workout(id: 68, name: "V-Ups", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 15, isAdded: false),
        Workout(id: 69, name: "Flutter Kicks", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 50, isAdded: false),
        Workout(id: 70, name: "Hollow Hold", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 45, isAdded: false),
        Workout(id: 71, name: "Superman", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 20, isAdded: false),
        Workout(id: 72, name: "Hip Bridges", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 15, isAdded: false),
        Workout(id: 73, name: "Bird Dog", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 20, isAdded: false),
        Workout(id: 74, name: "Toe Touches", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 25, isAdded: false),
        Workout(id: 75, name: "Scissor Kicks", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 40, isAdded: false),
        Workout(id: 76, name: "Lying Leg Curls", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 15, isAdded: false),
        Workout(id: 77, name: "Hanging Leg Raise", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 12, isAdded: false),
        Workout(id: 78, name: "Ab Wheel Rollout", type: "Other", weight: 0, weights: [0: ""], sets: 3, reps: 15, isAdded: false),
        
        //cardio workouts
        Workout(id: 79, name: "Treadmill", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 80, name: "Elliptical", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 81, name: "Stationary Bike", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 82, name: "Rowing Machine", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 83, name: "Jump Rope", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 84, name: "Swimming", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 85, name: "Running Outdoors", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 86, name: "Hiking", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 87, name: "Stair Climber", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 88, name: "Dance", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 89, name: "Aerobics", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 90, name: "High-Intensity Interval Training (HIIT)", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 91, name: "Kickboxing", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 92, name: "Cycling Outdoors", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 93, name: "Rowing Outdoors", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 94, name: "Speed Walking", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 95, name: "Skiing", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 96, name: "Skating", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 97, name: "Surfing", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false),
        Workout(id: 98, name: "Paddleboarding", type: "Cardio", weight: 0, weights: [0: ""], sets: 0, reps: 0, isAdded: false)
    ]


    
    @State private var searchTerm = ""
    
    var filteredWorkouts: [Workout] {
        guard !searchTerm.isEmpty else { return workoutTypes }
        return workoutTypes.filter { $0.name.localizedCaseInsensitiveContains(searchTerm)}
    }
    var body: some View {
            NavigationStack {
                List(filteredWorkouts) { workout in
                    Button {
                        toggleWorkoutSelection(workout)
                    } label: {
                        HStack {
                            Text(workout.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedWorkouts.contains(where: { $0.id == workout.id }) {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding()
                        .background(selectedWorkouts.contains(where: { $0.id == workout.id }) ? Color.blue.opacity(0.1) : Color.clear)
                        .cornerRadius(8)
                    }
                }
                .searchable(text: $searchTerm, placement: .automatic, prompt: "Search Workouts")
                .navigationTitle("Add Workouts From Log")
                .toolbar {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        
        private func toggleWorkoutSelection(_ workout: Workout) {
            if let index = selectedWorkouts.firstIndex(where: { $0.id == workout.id }) {
                selectedWorkouts.remove(at: index)
            } else {
                selectedWorkouts.append(workout)
            }
        }
}


