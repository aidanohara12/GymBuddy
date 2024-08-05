//
//  UserFitnessView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData

struct UserFitnessView: View {
    @State var manager = UserHealthViewModel()
    let user: User

    
    var body: some View {
        NavigationStack {
            Text("WorkoutTracker")
                .font(.title3.bold())
            ScrollView {
                if manager.workouts.isEmpty {
                    Image(systemName: "person.slash.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                    Text("No workouts available. Add workouts in the health app or on your Apple Watch to view them here!")
                        .multilineTextAlignment(.center)
                        .font(.callout)
                        .padding()
                } else {
                    HStack {
                        Text("Recent Workouts")
                            .font(.title2)
                        
                        Spacer()
                    }
                    .padding()
                    
                    VStack {
                        ForEach(manager.workouts, id: \.date) { workout in
                            WorkoutCard(lift: workout)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .background(Color.blue.opacity(0.4))
            .navigationTitle("\(user.firstname)'s Workouts")
        }
    }
    
}

//#Preview {
//    UserFitnessView()
//}
