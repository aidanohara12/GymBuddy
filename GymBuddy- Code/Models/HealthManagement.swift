//
//  HealthManagement.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/29/24.
//

import Foundation
import HealthKit

extension Date {
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    static var startOfWeekMonday: Date? {
        let calandar = Calendar.current
        let componenets = calandar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())
        
        return calandar.date(from: componenets)
    }
    
    func fetchMonthStartDateAndEndDate() -> (Date, Date) {
        let calandar = Calendar.current
        let startDateComponenet = calandar.dateComponents([.year, .month], from: calandar.startOfDay(for: self))
        
        let startDate = calandar.date(from: startDateComponenet) ?? self
        
        let endDate = calandar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) ?? self
        
        return (startDate, endDate)
        
    }
    
    func formatWorkoutDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/d"
        return formatter.string(from: self)
    }
}

extension Double {
    func formattedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

class HealthManagement {
    static let shared = HealthManagement()
    
    let healthStore = HKHealthStore()
    
    private init() {
        Task {
            do {
                try await requestHealthKitAccess()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func requestHealthKitAccess() async throws {
        let calories = HKQuantityType(.activeEnergyBurned)
        let exersice = HKQuantityType(.appleExerciseTime)
        let stand = HKCategoryType(.appleStandHour)
        let steps = HKQuantityType(.stepCount)
        let workout = HKSampleType.workoutType()
        
        let healthTypes: Set = [calories, exersice, stand, steps, workout]
        try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
    }
    
    func fetchTodayCaloriesBurned(completion: @escaping(Result<Double, Error>) -> Void) {
        let calories = HKQuantityType(.activeEnergyBurned)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: calories, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let calorieCount = quantity.doubleValue(for: .kilocalorie())
            completion(.success(calorieCount))
            
        }
        healthStore.execute(query)
    }
    
    func fetchTodayExcerciseTime(completion: @escaping(Result<Double, Error>) -> Void) {
        let exercise = HKQuantityType(.appleExerciseTime)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: exercise, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let exerciseTime = quantity.doubleValue(for: .minute())
            completion(.success(exerciseTime))
            
        }
        healthStore.execute(query)
    }
    
    func fetchTodayStandHours(completion: @escaping(Result<Int, Error>) -> Void) {
        let stand = HKCategoryType(.appleStandHour)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKSampleQuery(sampleType: stand, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, results, error in
            guard let samples = results as? [HKCategorySample], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
        }
            print(samples)
            print(samples.map({ $0.value}))
            let standCount = samples.filter({ $0.value == 0}).count
            completion(.success(standCount))
            
        }
        healthStore.execute(query)
    }
    
    // MARK: Fitness Activity
    func fetchTodaySteps(completion: @escaping(Result<Activity, Error>) -> Void) {
        let steps = HKQuantityType(.stepCount)
        let predicate = HKQuery.predicateForSamples(withStart: .startOfDay, end: Date())
        let query = HKStatisticsQuery(quantityType: steps, quantitySamplePredicate: predicate) { _, result, error in
            guard let quantity = result?.sumQuantity(), error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            let steps = quantity.doubleValue(for: .count())
            let activity = Activity(id: 0, title: "Steps", subtitle: "Today", image: "figure.walk", amount: steps.formattedString(), tintColor: .green)
            completion(.success(activity))
            
        }
        healthStore.execute(query)
    }
    
    func fetchCurrentWeekWorkoutStats(completion: @escaping(Result<[Activity], Error>) -> Void) {
        let workout = HKSampleType.workoutType()
        let predicate = HKQuery.predicateForSamples(withStart: .startOfWeekMonday, end: Date())
        let query = HKSampleQuery(sampleType: workout, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil) { _, sample, error in
            guard let workouts = sample as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }
            
            var runningCount: Int = 0
            var strengthCount: Int = 0
            var cyclingCount: Int = 0
            var ellipticalCount: Int = 0
            var stairStepper: Int = 0
            var yogaCount: Int = 0
            
            for workout in workouts {
                if workout.workoutActivityType == .running {
                    let duration = Int(workout.duration)/60
                    runningCount += duration
                } else if workout.workoutActivityType == .traditionalStrengthTraining {
                    let duration = Int(workout.duration)/60
                    strengthCount += duration
                } else if workout.workoutActivityType == .cycling {
                    let duration = Int(workout.duration)/60
                    cyclingCount += duration
                } else if workout.workoutActivityType == .elliptical {
                    let duration = Int(workout.duration)/60
                    ellipticalCount += duration
                }
                else if workout.workoutActivityType == .stairClimbing {
                    let duration = Int(workout.duration)/60
                    stairStepper += duration
                }
                else if workout.workoutActivityType == .yoga {
                    let duration = Int(workout.duration)/60
                    yogaCount += duration
                }
                
                
            }
            
            let runningActivity = Activity(id: 2, title: "Running", subtitle: "This Week", image: "figure.run", amount: "\(runningCount) mins", tintColor: .green)
            let strengthActivity = Activity(id: 3, title: "Weight Lifting", subtitle: "This Week", image: "figure.strengthtraining.traditional", amount: "\(strengthCount) minutes", tintColor: .cyan)
            let cyclingActivity = Activity(id: 4, title: "Cycling", subtitle: "This Week", image: "figure.outdoor.cycle", amount: "\(cyclingCount) mins", tintColor: .green)
            let ellipticalActivity = Activity(id: 5, title: "Elliptical", subtitle: "This Week", image: "figure.elliptical", amount: "\(ellipticalCount) mins", tintColor: .green)
            let stairActivity = Activity(id: 6, title: "Stair Stepper", subtitle: "This Week", image: "figure.stair.stepper", amount: "\(stairStepper) mins", tintColor: .green)
            let yogaActivity = Activity(id: 7, title: "Yoga", subtitle: "This Week", image: "figure.yoga", amount: "\(stairStepper) mins", tintColor: .purple)
            
            completion(.success([runningActivity,strengthActivity,cyclingActivity,ellipticalActivity,stairActivity,yogaActivity]))
            
            
        }
        healthStore.execute(query)
    }
    
    //MARK: Recent workouts
    
    func fetchWorkoutsForMonth(month: Date, completion: @escaping (Result<[Lift], Error>) -> Void) {
        let workouts = HKSampleType.workoutType()
        let (startDate, endDate) = month.fetchMonthStartDateAndEndDate()
        let timePredicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate)
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(sampleType: workouts, predicate: timePredicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, error in
            guard let workouts = results as? [HKWorkout], error == nil else {
                completion(.failure(URLError(.badURL)))
                return
            }

            
            let workoutsArray = workouts.map( { Lift(id: $0.uuid, title: $0.workoutActivityType.name, image: $0.workoutActivityType.image, duration: "\(Int($0.duration/60)) minutes", date: $0.startDate.formatWorkoutDate(), tint: $0.workoutActivityType.color, calories: "\($0.totalEnergyBurned?.doubleValue(for: .kilocalorie()).formattedString() ?? "-") kcal")})
            completion(.success(workoutsArray))
        }
        healthStore.execute(query)
    }
}
