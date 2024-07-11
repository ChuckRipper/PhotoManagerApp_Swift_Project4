//
//  Photo.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Fluent
import Vapor

final class ServerPhoto: Model, Content {
    static let schema = "photos"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "url")
    var url: String

    @Parent(key: "album_id")
    var album: ServerAlbum

    init() {}

    init(id: UUID? = nil, title: String, url: String, albumId: UUID) {
        self.id = id
        self.title = title
        self.url = url
        self.$album.id = albumId
    }
}

