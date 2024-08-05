//
//  Workout.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import Foundation
import SwiftData

@Model
class Workout: Identifiable, Equatable {
    var id: Int
    var name: String
    var type: String
    var weight: Int
    var weights: Dictionary<Int, String>
    var sets: Int
    var reps: Int
    var gym: Gym?
    var log: Log?
    var isAdded: Bool
    
    init(id: Int, name: String, type: String, weight: Int, weights: Dictionary<Int, String>, sets: Int, reps: Int, gym: Gym? = nil, log: Log? = nil, isAdded: Bool) {
        self.id = id
        self.name = name
        self.type = type
        self.weight = weight
        self.weights = weights
        self.sets = sets
        self.reps = reps
        self.gym = gym
        self.log = log
        self.isAdded = isAdded
    }
}

