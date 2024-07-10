//
//  Comment.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation

struct Comment: Codable, Identifiable {
    var id: UUID?
    var text: String
    var photoId: UUID
    var userId: UUID
}

