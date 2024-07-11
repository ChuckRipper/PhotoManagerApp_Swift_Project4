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
    private static func main() throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let app = Application(env)
        defer { app.shutdown() }
//        try configure(app)
//        try app.run()
        
        // Konfiguracja bazy danych
        try configure(app)
        
        // Rejestracja tras
        try routes(app)
        
        // Uruchomienie aplikacji
        try app.run()
        
    }

    private static func configure(_ app: Application) throws {
        // Konfiguracja po¬åczenia z bazå danych
        app.databases.use(.sqlite(.file("db.sqlite")), as: .sqlite)
        
        // Migracje
        app.migrations.add(CreateUser())
        app.migrations.add(CreateAlbum())
        app.migrations.add(CreatePhoto())
        app.migrations.add(CreateComment())
        
        // Wykonanie migracji
        try app.autoMigrate().wait()

//        let userController = UserController()
//        try app.register(collection: userController)
//
//        let photoController = PhotoController()
//        try app.register(collection: photoController)
//
//        let commentController = CommentController()
//        try app.register(collection: commentController)
//
//        let albumController = AlbumController()
//        try app.register(collection: albumController)
        
    }
    
    private static func routes(_ app: Application) throws {
        // Rejestracja kontrolerów
        let authService = AuthService()
        let photoStorageService = PhotoStorageService()
        
        app.post("register") { req -> EventLoopFuture<ServerUser> in
            try authService.register(req: req)
        }
        
        app.post("login") { req -> EventLoopFuture<ServerUser> in
            try authService.login(req: req)
        }
        
        app.post("storePhoto") { req -> EventLoopFuture<ServerPhoto> in
            let photo = try req.content.decode(ServerPhoto.self)
            return try photoStorageService.storePhoto(req: req, photo: photo)
        }
        
        app.get("fetchPhoto", ":photoID") { req -> EventLoopFuture<Response> in
            guard let photoID = req.parameters.get("photoID", as: UUID.self) else {
                throw Abort(.badRequest)
            }
            return try photoStorageService.fetchPhoto(req: req, photoID: photoID)
        }
    }
    
    
}
