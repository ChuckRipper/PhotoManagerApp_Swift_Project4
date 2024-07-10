//
//  Album.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Fluent
import Vapor

final class ServerAlbum: Model, Content {
    static let schema = "albums"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Parent(key: "user_id")
    var user: ServerUser

    init() {}

    init(id: UUID? = nil, title: String, userId: UUID) {
        self.id = id
        self.title = title
        self.$user.id = userId
    }
}

