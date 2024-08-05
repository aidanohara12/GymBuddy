//
//  User.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import Foundation
import SwiftData
import PhotosUI
import SwiftUI

@Model
class User {
    //have user enter first and last name and body data
    var firstname: String
    var lastname: String
    var age: Date
    var howOld: Int {
        let ageComponents = Calendar.current.dateComponents([.year], from: age, to: Date())
        return ageComponents.year!
    }
    var height: Dictionary<Int,Int>
    var weight: Double
    var weightGoal: Double?
    //create arrays of gyms and log for the user
    @Relationship(deleteRule: .cascade) var gyms: [Gym] = []
    @Relationship(deleteRule: .cascade) var logs: [Log] = []
    
    //for logs
    var streak = [0 , 0 , 0 , 0 , 0 , 0, 0]
    var continuusStreak = 0
    var sundayInput = false
    
    
    
    //init for userdata
    init(firstname: String, lastname: String, age: Date, height: Dictionary<Int, Int>, weight: Double) {
        self.firstname = firstname
        self.lastname = lastname
        self.age = age
        self.height = height
        self.weight = weight
    }
    
}
