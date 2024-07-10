//
//  Album.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation

struct Album: Codable, Identifiable {
    var id: UUID?
    var title: String
    var userId: UUID
}

