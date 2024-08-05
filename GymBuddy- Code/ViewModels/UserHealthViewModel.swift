//
//  UserHealthViewModel.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/29/24.
//

import Foundation

class UserHealthViewModel: ObservableObject {
    let healthManagement = HealthManagement.shared
    
    @Published var calories: Int = 0
    @Published var exercise: Int = 0
    @Published var stand: Int = 0
    
    @Published var activities = [Activity]()
    @Published var workouts = [Lift]()
    
    init() {
        Task {
            do {
                try await healthManagement.requestHealthKitAccess()
                fetchTodayCalories()
                fetchTodayExerciseTime()
                fetchTodayStandHours()
                fetchTodaySteps()
                fetchCurrentWeekActivites()
                fetchRecentWorkouts()
            
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTodayCalories() {
        healthManagement.fetchTodayCaloriesBurned { result in
            switch result  {
            case .success(let calories):
                DispatchQueue.main.async {
                    self.calories = Int(calories)
                    let activity = Activity(id: 1, title: "Calories Burned", subtitle: "Today", image: "flame", amount: calories.formattedString(), tintColor: .red)
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayExerciseTime() {
        healthManagement.fetchTodayExcerciseTime { result in
            switch result  {
            case .success(let exercise):
                DispatchQueue.main.async {
                    self.exercise = Int(exercise)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchTodayStandHours() {
        healthManagement.fetchTodayStandHours { result in
            switch result  {
            case .success(let hours):
                DispatchQueue.main.async {
                    self.stand = hours
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    // MARK: Fitness Activity
    
    func fetchTodaySteps() {
        healthManagement.fetchTodaySteps { result in
            switch result  {
            case .success(let activity):
                DispatchQueue.main.async {
                    self.activities.append(activity)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchCurrentWeekActivites() {
        healthManagement.fetchCurrentWeekWorkoutStats { result in
            switch result  {
            case .success(let activities):
                DispatchQueue.main.async {
                    self.activities.append(contentsOf: activities)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func fetchRecentWorkouts() {
        healthManagement.fetchWorkoutsForMonth(month: Date()) { result in
            switch result  {
            case .success(let workouts):
                DispatchQueue.main.async {
                    self.workouts = workouts
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
