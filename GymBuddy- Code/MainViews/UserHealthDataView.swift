//
//  UserHealthDataView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData
import StoreKit
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct UserHealthDataView: View {
    let user: User
    @State private var sheetIsShowing = false
    
    @State var viewModel = UserHealthViewModel()
    
    
    var body: some View {
        NavigationStack {
            Text("Press Edit to Change your Health Data!")
                .font(.caption.bold())
            ScrollView {
                HStack {
                    VStack(alignment: .center) {
                        Text("Age: \(user.howOld)")
                            .font(.title2)
                        Text("Height: \(user.height.keys.first!) feet \(user.height.values.first!) inches")
                            .font(.title2)
                        Text("Weight: \(user.weight.formatted())")
                            .font(.title2)
                    }
                    .padding()
                }
                VStack {
                    Text("Todays Current Health Statistics")
                        .font(.title2.bold())
                    if !viewModel.activities.isEmpty {
                        LazyVGrid(columns: Array(repeating: GridItem(spacing: 20), count: 2)) {
                            ForEach(viewModel.activities, id: \.id) { activity in
                                ActivityCard(activity: activity)
                            }
                        }
                        .padding(.horizontal)
                    } else {
                        Text("User has no health data")
                            .font(.title3)
                        Text("Try allowing access to Health data to view")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.6))
                    }
                }
            }            
            .background(.blue.opacity(0.4))
            .scrollContentBackground(.hidden)
            .navigationTitle("\(user.firstname)'s Health")
            .toolbar {
                Button("Edit") {
                    sheetIsShowing.toggle()
                }
            }
            .sheet(isPresented: $sheetIsShowing) {
                EditUserHealthView(user: user)
            }
        }
        
    }
    
}
