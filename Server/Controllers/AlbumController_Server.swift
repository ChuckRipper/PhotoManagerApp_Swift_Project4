//
//  AlbumController.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Vapor
import Fluent

struct AlbumController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let albumsRoute = routes.grouped("albums")
        albumsRoute.get(use: getAllHandler)
        albumsRoute.post(use: createHandler)
        albumsRoute.get(":albumID", use: getHandler)
        albumsRoute.put(":albumID", use: updateHandler)
        albumsRoute.delete(":albumID", use: deleteHandler)
    }

    func getAllHandler(req: Request) -> EventLoopFuture<[ServerAlbum]> {
        ServerAlbum.query(on: req.db).all()
    }

    func createHandler(req: Request) throws -> EventLoopFuture<ServerAlbum> {
        let album = try req.content.decode(ServerAlbum.self)
        return album.save(on: req.db).map { album }
    }

    func getHandler(req: Request) throws -> EventLoopFuture<ServerAlbum> {
        ServerAlbum.find(req.parameters.get("albumID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func updateHandler(req: Request) throws -> EventLoopFuture<ServerAlbum> {
        let updatedAlbum = try req.content.decode(ServerAlbum.self)
        return ServerAlbum.find(req.parameters.get("albumID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { album in
                album.title = updatedAlbum.title
                album.$user.id = updatedAlbum.$user.id
                return album.save(on: req.db).map { album }
            }
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        ServerAlbum.find(req.parameters.get("albumID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { album in
                album.delete(on: req.db)
            }.transform(to: .ok)
    }
}
