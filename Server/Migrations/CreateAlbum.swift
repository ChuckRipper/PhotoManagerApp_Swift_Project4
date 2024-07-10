//
//  CreateAlbum.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

//import Foundation
import Fluent

struct CreateAlbum: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("albums")
            .id()
            .field("title", .string, .required)
            .field("user_id", .uuid, .required, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("albums").delete()
    }
}

