//
//  LogView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI

struct LogView: View {
    let log: Log
    var body: some View {
        ZStack {
            Color.blue.opacity(0.4)
                .ignoresSafeArea()
            
            VStack {
                Text("Workout from " + log.date.formatWorkoutDate())
                    .font(.largeTitle.bold())
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Divider()
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.3))
                
                Text("Intensity: \(log.intensity)")
                    .font(.title)
                    .bold()
                    .padding(.vertical, 10)
                
                Divider()
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.3))
                
                if !log.workouts.isEmpty {
                    VStack(alignment: .center, spacing: 20) {
                        
                        VStack(alignment: .center) {
                            Text("Workouts Done:")
                                .font(.headline)
                                .padding(.bottom, 5)
                            
                            List(log.workouts) { workout in
                                VStack(alignment: .leading) {
                                    Text(workout.name)
                                        .font(.title2)
                                        .bold()
                                    HStack {
                                        Text("Type: \(workout.type)")
                                            .font(.subheadline)
                                        Spacer()
                                    }
                                    .padding(.top, 2)
                                }
                                .padding(.vertical, 5)
                            }
                            .listStyle(InsetGroupedListStyle())
                            .scrollContentBackground(.hidden)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.vertical, 20)
                } else {
                    if log.restDay {
                        Text("Rest Day")
                            .font(.title.bold())
                    } else {
                        VStack(alignment: .center, spacing: 10) {
                            Text("No workouts were done for this log!")
                                .font(.title)
                            Text("If that is a mistake, delete this and make the log again!")
                                .font(.caption)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.vertical, 20)
                    }
                }
                
                Divider()
                    .padding(.horizontal)
                    .background(Color.gray.opacity(0.3))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Gym Log")
                        .font(.title2)
                        .bold()
                    Text(log.log)
                        .font(.body)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .padding(.vertical, 20)
                
                Spacer()
            }
            .padding(.top)
        }
    }


}


