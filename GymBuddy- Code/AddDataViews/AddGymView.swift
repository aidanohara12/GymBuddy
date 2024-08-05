//
//  AddGymView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftData
import SwiftUI

struct AddGymView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    let user: User
    
    @State private var name = ""
    @State private var city = ""
    @State private var state = "AK"
    @State private var type = "Personal"
    
    
    let types = ["Personal", "School", "Work"]
    
    let states = ["AK", "AL", "AR", "AS", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "GU", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MP", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UM", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.4).ignoresSafeArea()
                Form {
                    Section {
                        TextField("Name:", text: $name)
                        TextField("City:", text: $city)
                        Picker("State:", selection: $state) {
                            ForEach(states, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section {
                        Picker("What type of gym is this", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Section {
                        Button("Save Gym") {
                            let gym = Gym(name: name, city: city, state: state, type: type)
                            user.gyms.append(gym)
                            dismiss()
                        }
                        .disabled(name.isEmpty || city.isEmpty)
                    }
                }
            }
            .navigationTitle("Enter Gym Details")
            .scrollBounceBehavior(.basedOnSize)
        }
        .scrollContentBackground(.hidden)
    }
}

