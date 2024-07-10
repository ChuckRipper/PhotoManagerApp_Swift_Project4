//
//  CreatePhoto.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

//import Foundation
import Fluent

struct CreatePhoto: Migration {
    func prepare(on database: Database) -> EventLoopFuture<Void> {
        database.schema("photos")
            .id()
            .field("title", .string, .required)
            .field("url", .string, .required)
            .field("album_id", .uuid, .required, .references("albums", "id"))
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        database.schema("photos").delete()
    }
}

