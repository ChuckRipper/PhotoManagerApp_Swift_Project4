//
//  Comment.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Fluent
import Vapor

final class ServerComment: Model, Content {
    static let schema = "comments"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "text")
    var text: String

    @Parent(key: "photo_id")
    var photo: ServerPhoto

    @Parent(key: "user_id")
    var user: ServerUser

    init() {}

    init(id: UUID? = nil, text: String, photoId: UUID, userId: UUID) {
        self.id = id
        self.text = text
        self.$photo.id = photoId
        self.$user.id = userId
    }
}
