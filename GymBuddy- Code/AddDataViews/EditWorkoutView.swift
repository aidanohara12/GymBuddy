//
//  EditWorkoutView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData

struct EditWorkoutView: View {
    let workout: Workout
    
    @FocusState private var focusedItem: Bool
    
    @State private var weight = ""
    
    @State private var sets = 3
    @State private var reps = 12
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("\(workout.sets)x\(workout.reps) \(workout.weight) lbs")
                    .padding()
                    .font(.title3.bold())
                VStack {
                    TextField("Add New Weight", text: $weight)
                        .onSubmit {
                            focusedItem = false
                        }
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(maxWidth: 250)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .border(Color.black)
                        .padding()
                        .focused($focusedItem)
                    VStack {
                        Text("Edit Sets and Reps")
                        Stepper("Sets: \(sets)", value: $sets,  in: 1...6)
                        Stepper("Reps: \(reps)", value: $reps,  in: 1...120)
                    }
                    Button("Save") {
                        addWeight(weight: weight)
                        focusedItem = false
                    }
                    .disabled(weight.isEmpty)
                    .padding()
                    .font(.title3.bold())
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .shadow(radius: 10)
                    .overlay(
                        Capsule()
                            .stroke(.blue.opacity(0.7), lineWidth: 5)
                    )
                }
                .padding()
                Rectangle()
                    .frame(height: 0.4)
                    .background(.gray.opacity(0.8))
                    .padding()
                VStack {
                    Text("Past Weights:")
                        .font(.title.bold())
                    
                    List{
                        let sortedKeys = workout.weights.keys.sorted(by: >)
                        ForEach(sortedKeys, id: \.self) {key in
                            if key != 0 {
                                Text("\(key) lbs: \(workout.weights[key] ?? " ")")
                            }
                            
                        }
                        
                    }
                }
            }
            .background(.blue.opacity(0.4))
            .scrollContentBackground(.hidden)
            .navigationTitle(workout.name)
            .navigationBarTitleDisplayMode(.large)
        }
    }
    func addWeight(weight: String) {
        let weights = Int(weight)
        workout.weight = weights!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let formattedDate = dateFormatter.string(from: Date())
        workout.weights[weights!] = formattedDate
        workout.reps = reps
        workout.sets = sets
    }
}

