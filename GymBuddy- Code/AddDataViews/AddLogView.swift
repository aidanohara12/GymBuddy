//
//  AddLogView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData

struct AddLogView: View {
    @Environment(\.dismiss) var dismiss
    let user: User
    
    @State private var date = Date.now
    @State private var intensity = 5.0
    @State private var log = ""
    @State private var gym = ""
    
    @State private var sheetIsShowing = false
    @State private var isRestDay = false
    
    @State var selectedWorkouts: [Workout] = []
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Workout from " + date.formatWorkoutDate())
                        .font(.title.bold())
                        .padding(.top)
                    
                    Spacer()
                    
                    Form {
                        Group {
                            if user.gyms.isEmpty {
                                Text("Please Add Your Gym Before Adding a Log!")
                                    .bold()
                                    .padding()
                            } else {
                                VStack {
                                    Picker("What gym did you workout at", selection: $gym) {
                                        ForEach(user.gyms, id: \.self) { gym in
                                            Text(gym.name).tag(gym.name)
                                        }
                                    }
                                    .pickerStyle(MenuPickerStyle())
                                    .padding()
                                    
                                    Toggle("Rest Day?", isOn: $isRestDay)
                                    
                                    if !isRestDay {
                                        Button {
                                            sheetIsShowing.toggle()
                                        } label: {
                                            Text("Add Workouts/Cardio Done Today")
                                                .multilineTextAlignment(.center)
                                        }
                                        .frame(width: 250, height: 50)
                                        .foregroundColor(.white)
                                        .background(user.gyms.isEmpty ? Color.gray : Color.blue)
                                        .clipShape(Capsule())
                                        .padding()
                                        
                                        
                                        List(selectedWorkouts) { workout in
                                            Text(workout.name)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Group {
                            VStack {
                                Text("How tough was your workout?")
                                Slider(value: $intensity, in: 0...10, step: 1.0)
                                    .padding()
                                Text("Workout Intensity: \(intensity, specifier: "%.0f")")
                                    .font(.subheadline)
                            }
                        }
                        
                        Group {
                            VStack(alignment: .leading) {
                                Text("Log how your workout went below!")
                                    .font(.title2)
                                TextField("Workout Log", text: $log, axis: .vertical)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.top)
                            }
                        }
                    }
                    
                    Button("Save") {
                        let log = Log(date: Date(), intensity: Int(intensity), log: log, gym: gym)
                        log.workouts.append(contentsOf: selectedWorkouts)
                        if isRestDay {
                            log.restDay = true
                        }
                        user.logs.append(log)
                        let now = Date()
                        checkStreak()
                        user.streak[dayOfWeek(for: now)!] = 1
                        if dayOfWeek(for: now) == 0 {
                            user.sundayInput = true
                        }
                        dismiss()
                    }
                    .frame(width: 100, height: 50)
                    .foregroundColor(.white)
                    .background(user.gyms.isEmpty ? Color.gray : Color.blue)
                    .clipShape(Capsule())
                    .padding(.bottom)
                    
                }
                .sheet(isPresented: $sheetIsShowing) {
                    AddLogWorkoutView(selectedWorkouts: $selectedWorkouts)
                }
                .scrollContentBackground(.hidden)
            }
        }
    }

    func dayOfWeek(for date: Date) -> Int? {
        let calendar = Calendar.current
        let component = calendar.component(.weekday, from: date)
        return component - 1
    }

    func checkStreak() {
        let date = Date()
        let day = dayOfWeek(for: date)!
        if day > 0 {
            if user.streak[day-1] == 0 && user.streak[day] != 1 {
                user.continuusStreak = 0
            }
        }
        if user.streak[day] == 0 {
            user.continuusStreak += 1
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
       
        
        return AddLogView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create prieview:  \(error.localizedDescription)")
    }
}
