//
//  ContentView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}

//import SwiftUI
//import CoreData
//
//struct ContentView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: LoginView()) {
//                    Text("Login")
//                }
//                NavigationLink(destination: RegisterView()) {
//                    Text("Register")
//                }
//            }
//            .navigationBarTitle("Photo Manager")
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

import SwiftUI

struct ContentView: View {
    @StateObject private var userViewModel = UserViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(userViewModel.users) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Text(user.username)
                    }
                }
                .onDelete(perform: deleteUser)
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: {
                userViewModel.fetchUsers()
            }) {
                Image(systemName: "arrow.clockwise")
            })
            .onAppear {
                userViewModel.fetchUsers()
            }
        }
    }
    
    private func deleteUser(at offsets: IndexSet) {
        offsets.forEach { index in
            let user = userViewModel.users[index]
            if let id = user.id {
                userViewModel.deleteUser(id: id)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
