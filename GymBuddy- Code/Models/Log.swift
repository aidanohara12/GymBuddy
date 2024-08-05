//
//  Log.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import Foundation
import SwiftData

@Model
class Log: Identifiable, Equatable {
    //create new var for Log Class
    var date: Date
    var intensity: Int
    var log: String
    var gym: String
    
    var workouts: [Workout] = []
    
    var restDay = false

    var owner: User?
    
    init(date: Date, intensity: Int, log: String, gym: String) {
        self.date = date
        self.intensity = intensity
        self.log = log
        self.gym = gym
    }
    
    
}
