//
//  main.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Vapor
import Fluent
import FluentSQLiteDriver

//@main
struct MainApp_Server {
    static func main() throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let app = Application(env)
        defer { app.shutdown() }
        try configure(app)
        try app.run()
    }

    static func configure(_ app: Application) throws {
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)

        app.migrations.add(CreateUser())
        app.migrations.add(CreateAlbum())
        app.migrations.add(CreatePhoto())
        app.migrations.add(CreateComment())

        try app.autoMigrate().wait()

        let userController = UserController()
        try app.register(collection: userController)

        let photoController = PhotoController()
        try app.register(collection: photoController)

        let commentController = CommentController()
        try app.register(collection: commentController)

        let albumController = AlbumController()
        try app.register(collection: albumController)
    }
}
