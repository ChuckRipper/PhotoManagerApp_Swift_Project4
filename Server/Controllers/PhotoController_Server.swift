//
//  PhotoController.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Vapor
import Fluent

struct PhotoController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let photosRoute = routes.grouped("photos")
        photosRoute.get(use: getAllHandler)
        photosRoute.post(use: createHandler)
        photosRoute.get(":photoID", use: getHandler)
        photosRoute.put(":photoID", use: updateHandler)
        photosRoute.delete(":photoID", use: deleteHandler)
    }

    func getAllHandler(req: Request) -> EventLoopFuture<[ServerPhoto]> {
        ServerPhoto.query(on: req.db).all()
    }

    func createHandler(req: Request) throws -> EventLoopFuture<ServerPhoto> {
        let photo = try req.content.decode(ServerPhoto.self)
        return photo.save(on: req.db).map { photo }
    }

    func getHandler(req: Request) throws -> EventLoopFuture<ServerPhoto> {
        ServerPhoto.find(req.parameters.get("photoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func updateHandler(req: Request) throws -> EventLoopFuture<ServerPhoto> {
        let updatedPhoto = try req.content.decode(ServerPhoto.self)
        return ServerPhoto.find(req.parameters.get("photoID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { photo in
                photo.title = updatedPhoto.title
                photo.url = updatedPhoto.url
                photo.$album.id = updatedPhoto.$album.id
                return photo.save(on: req.db).map { photo }
            }
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        ServerPhoto.find(req.parameters.get("photoID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { photo in
                photo.delete(on: req.db)
            }.transform(to: .ok)
    }
}
