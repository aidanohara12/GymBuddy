//
//  NoUserView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//


import SwiftUI

struct NoUserView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var first = ""
    @State private var last = ""
    
    @State private var age = Date.now
    @State private var feet = 5
    @State private var inches = 6
    @State private var weight = ""
    
    let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter
        }()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.blue.opacity(0.3)
                    .ignoresSafeArea()
                Spacer()
                VStack(alignment: .center) {
                    Text("Please add a new user below")
                        .bold()
                        .multilineTextAlignment(.center)
                    ZStack {
                        Color.blue.opacity(0.3)
                            .cornerRadius(20)
                        VStack {
                            Text("Enter Name Below")
                                .padding()
                            VStack {
                                TextField("First", text: $first)
                                    .frame(width: 300, height: 50)
                                    .multilineTextAlignment(.center)
                                    .background(Color(UIColor.systemGray6))
                                    .clipShape(Capsule(style: .continuous))
                                TextField("Last", text: $last)
                                    .frame(width: 300, height: 50)
                                    .multilineTextAlignment(.center)
                                    .background(Color(UIColor.systemGray6))
                                    .clipShape(Capsule(style: .continuous))
                            }
                            VStack {
                                DatePicker(selection: $age, in: ...Date.now, displayedComponents: .date) {
                                    Text("Select your Date of Birth")
                                }
                                
                                Text("Birthday is \(age, formatter: dateFormatter)")
                            }
                            .padding()
                            VStack {
                                Text("Enter Height")
                                HStack {
                                    Stepper("Ft", value: $feet, in: 3...7)
                                        .padding()
                                    Stepper("In", value: $inches, in: 0...12)
                                }
                                Text("Height: \(feet) feet \(inches) inches")
                            }
                            .padding()
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
                    }
                    Button("Save") {
                        let user = User(firstname: first, lastname: last, age: age, height: [feet: inches] , weight: Double(weight)!)
                        modelContext.insert(user)
                    }
                    .disabled(first.isEmpty || last.isEmpty || weight.isEmpty)
                    .frame(width: 150, height: 50)
                    .foregroundStyle(.white)
                    .background(.blue)
                    .clipShape(.capsule)
                }
                .padding()
            }
        }
    }
}

#Preview {
    NoUserView()
}
