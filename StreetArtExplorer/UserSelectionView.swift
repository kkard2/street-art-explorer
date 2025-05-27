//
//  UserSelectionView.swift
//  StreetArtExplorer
//
//  Created by student on 27/05/2025.
//

import SwiftUI

struct UserSelectionView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \User.creationDate, ascending: true)],
        animation: .default)
    private var users: FetchedResults<User>
    
    @State var newUsername: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("New user:")
                    TextField("username", text: $newUsername)
                    Button("Create") {
                        if newUsername.count > 0 && !(users.contains() { $0.username == newUsername }) {
                            let newUser = User(context: viewContext)
                            newUser.username = newUsername
                            newUser.creationDate = Date()
                            
                            do {
                                try viewContext.save()
                            } catch {
                                let nsError = error as NSError
                                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                            }
                        }
                    }
                }
                .padding()

                List {
                    ForEach(users, id: \.self) { user in
                        NavigationLink(destination: HomeView(user: user)) {
                            Text(user.username ?? "UNKNOWN")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    UserSelectionView()
}
