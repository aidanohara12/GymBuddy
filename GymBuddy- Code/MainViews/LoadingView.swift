//
//  LoadingView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        NavigationStack {
            Spacer()
            Text("Welcome to GymBuddy!")
                .font(.title.bold())
                .lineLimit(1)
                .padding()
            Spacer()
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundStyle(.tint)
                .padding()
            NavigationLink(destination: NoUserView()) {
                Text("Add Account By Clicking Here")
                    .font(.headline)
                    .frame(width: 300, height: 50)
                    .background(.blue.opacity(0.1))
                    .clipShape(.capsule)
            }
            Spacer()
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
