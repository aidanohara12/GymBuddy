//
//  EditUserHealthView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 8/1/24.
//

import SwiftUI

struct EditUserHealthView: View {
    let user: User
    @Environment(\.dismiss) var dismiss
    @State private var feet = 6
    @State private var inches = 0
    @State private var weight = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Height") {
                    
                    VStack {
                        HStack {
                            Stepper("Ft", value: $feet, in: 3...7)
                                .padding()
                            Stepper("In", value: $inches, in: 0...12)
                        }
                        Text("Height: \(feet) feet \(inches) inches")
                    }
                    
                }
                Section("Weight") {
                    VStack {
                        Text("Enter Weight below")
                        TextField("Weight", text: $weight)
                            .frame(width: 300, height: 50)
                            .multilineTextAlignment(.center)
                            .background(Color(UIColor.systemGray6))
                            .clipShape(Capsule(style: .continuous))
                            .padding()
                    }
                    .padding()
                }
                
                Button("Save") {
                    user.height = [feet : inches]
                    user.weight = Double(weight)!
                    dismiss()
                }
                .disabled(weight.isEmpty)
            }
            .background(.blue.opacity(0.4))
            .ignoresSafeArea()
            .scrollContentBackground(.hidden)
        }
    }
}

