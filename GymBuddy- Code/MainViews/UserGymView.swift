//
//  UserGymView.swift
//  GymBuddy
//
//  Created by Aidan O'Hara on 7/27/24.
//

import SwiftUI
import SwiftData

struct UserGymView: View {
    let user: User
    @State private var addingGymView = false
    var body: some View {
        NavigationStack {
            Text("Hello, \(user.firstname)!")
                .bold()
            List {
                Section(user.gyms.isEmpty ? "Press the plus button to add a new gym!" : "\(user.firstname)'s Gyms") {
                    ForEach(user.gyms) { gym in
                        NavigationLink(destination: GymView(gym: gym)) {
                            VStack(alignment: .leading) {
                                Text(gym.name)
                                    .font(.title)
                                HStack {
                                    Text("Location: \(gym.location), Type: \(gym.type)")
                                        .font(.subheadline)
                                        .foregroundStyle(.gray.opacity(0.5))
                                }
                            }
                        }
                    }
                    .onDelete(perform: deleteGyms)
                }
            }
            .background(.blue.opacity(0.4))
            .navigationTitle("GymBuddy")
            .sheet(isPresented: $addingGymView) {
                AddGymView(user: user)
            }
            .toolbar {
                Button("Add", systemImage: "plus") {
                    addingGymView.toggle()
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
    func deleteGyms(at offsets: IndexSet) {
        for offset in offsets {
            user.gyms.remove(at: offset)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: User.self, configurations: config)
//        let gym = Gym(name: "AnyTime Fitness", location: "Cranberry", type: "Personal")
//        let gym2 = Gym(name: "The Pete", location: "Pittsburgh", type: "School")
        let user = User(firstname: "Aidan", lastname: "O'Hara", age: Date.now, height: [6:1], weight: 200.0)
       
        
        return UserGymView(user: user)
            .modelContainer(container)
    } catch {
        return Text("Failed to create prieview:  \(error.localizedDescription)")
    }
}
