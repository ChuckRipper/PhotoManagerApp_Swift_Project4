//
//  UserDetailView.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/10/24.
//

import SwiftUI

struct UserDetailView: View {
    @ObservedObject var userViewModel = UserViewModel()
    var user: User
    
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
