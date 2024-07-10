//
//  User.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation

struct User: Codable, Identifiable {
    var id: UUID?
    var username: String
    var email: String
    var password: String
}
