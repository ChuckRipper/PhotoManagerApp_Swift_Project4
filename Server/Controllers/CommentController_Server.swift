//
//  CommentController.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Vapor
import Fluent

struct CommentController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let commentsRoute = routes.grouped("comments")
        commentsRoute.get(use: getAllHandler)
        commentsRoute.post(use: createHandler)
        commentsRoute.get(":commentID", use: getHandler)
        commentsRoute.put(":commentID", use: updateHandler)
        commentsRoute.delete(":commentID", use: deleteHandler)
    }

    func getAllHandler(req: Request) -> EventLoopFuture<[ServerComment]> {
        ServerComment.query(on: req.db).all()
    }

    func createHandler(req: Request) throws -> EventLoopFuture<ServerComment> {
        let comment = try req.content.decode(ServerComment.self)
        return comment.save(on: req.db).map { comment }
    }

    func getHandler(req: Request) throws -> EventLoopFuture<ServerComment> {
        ServerComment.find(req.parameters.get("commentID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func updateHandler(req: Request) throws -> EventLoopFuture<ServerComment> {
        let updatedComment = try req.content.decode(ServerComment.self)
        return ServerComment.find(req.parameters.get("commentID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { comment in
                comment.text = updatedComment.text
                comment.$photo.id = updatedComment.$photo.id
                comment.$user.id = updatedComment.$user.id
                return comment.save(on: req.db).map { comment }
            }
    }

    func deleteHandler(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        ServerComment.find(req.parameters.get("commentID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { comment in
                comment.delete(on: req.db)
            }.transform(to: .ok)
    }
}
