//
//  WorkoutCard.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI

struct Lift {
    let id: UUID
    let title: String
    let image: String
    let duration: String
    let date: String
    let tint: Color
    let calories: String
}

struct WorkoutCard: View {
    @State var lift: Lift
    
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemGray6)
                .cornerRadius(15)
            HStack {
                Image(systemName: lift.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 48, height: 48)
                    .foregroundColor(lift.tint)
                    .padding()
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                
                VStack {
                    HStack {
                        Text(lift.title)
                            .font(.title3.bold())
                        
                        Spacer()
                        
                        Text(lift.duration)
                    }
                    
                    HStack {
                        Text(lift.date)
                        
                        Spacer()
                        
                        Text(lift.calories)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    WorkoutCard(lift: Lift(id: UUID(), title: "Running", image: "figure.run", duration: "34 minutes", date: "Aug 3", tint: .red, calories: "345 kcal") )
}

