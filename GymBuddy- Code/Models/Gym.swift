//
//  Gym.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class Gym: ObservableObject {
    var name: String
    var city: String
    var state: String
    var location: String {
        return city + ", " + state
    }
    var type: String
    var owner: User?
    var workouts: [Workout] = []
    
    let types = ["Personal", "School", "Work"]
    
    
    init(name: String, city: String, state: String, type: String) {
        self.name = name
        self.city = city
        self.state = state
        self.type = type
    }
}
