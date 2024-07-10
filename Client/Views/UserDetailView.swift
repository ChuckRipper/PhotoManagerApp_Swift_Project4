//
//  UserDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/10/24.
//

//import SwiftUI
//
//struct UserDetailView: View {
//    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//    }
//}
//
//#Preview {
//    UserDetailView()
//}

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var userViewModel = UserViewModel()
    var user: User
    
//    var body: some View {
//        VStack {
//            TextField("Username", text: $userViewModel.user?.username ?? "")
//            TextField("Email", text: $userViewModel.user?.email ?? "")
//            TextField("Password", text: $userViewModel.user?.password ?? "")
//            
//            Button("Update User") {
//                userViewModel.updateUser(user)
//            }
//        }
//        .onAppear {
//            userViewModel.fetchUser(id: user.id!)
//        }
//    }
    
    var body: some View {
           VStack {
               TextField("Username", text: Binding(
                   get: { userViewModel.user?.username ?? "" },
                   set: { userViewModel.user?.username = $0 }
               ))
               TextField("Email", text: Binding(
                   get: { userViewModel.user?.email ?? "" },
                   set: { userViewModel.user?.email = $0 }
               ))
               TextField("Password", text: Binding(
                   get: { userViewModel.user?.password ?? "" },
                   set: { userViewModel.user?.password = $0 }
               ))
               
               Button("Update User") {
                   if let user = userViewModel.user {
                       userViewModel.updateUser(user)
                   }
               }
           }
           .onAppear {
               userViewModel.fetchUser(id: user.id!)
           }
       }
}
