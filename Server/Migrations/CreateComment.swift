//
//  CreateComment.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

//import Foundation
import Fluent

struct CreateComment: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("comments")
            .id()
            .field("text", .string, .required)
            .field("photo_id", .uuid, .required, .references("photos", "id"))
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("comments").delete()
    }
}


