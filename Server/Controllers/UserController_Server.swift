//
//  UserController.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Vapor
import Fluent

struct UserController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let usersRoute = routes.grouped("users")
        usersRoute.post("login", use: login)
        usersRoute.post("register", use: register)
        usersRoute.get(use: getAllUsers)
        usersRoute.get(":userID", use: getUser)
        usersRoute.put(":userID", use: updateUser)
        usersRoute.delete(":userID", use: deleteUser)
    }

    func login(req: Request) throws -> EventLoopFuture<ServerUser> {
        let user = try req.content.decode(ServerUser.self)
        // Authenticate user
        return ServerUser.query(on: req.db)
            .filter(\ServerUser.$username == user.username)
            .first()
            .unwrap(or: Abort(.notFound))
    }

    func register(req: Request) throws -> EventLoopFuture<ServerUser> {
        let user = try req.content.decode(ServerUser.self)
        // Hash password and save user
        return user.save(on: req.db).map { user }
    }

    func getAllUsers(req: Request) throws -> EventLoopFuture<[ServerUser]> {
        ServerUser.query(on: req.db).all()
    }

    func getUser(req: Request) throws -> EventLoopFuture<ServerUser> {
        ServerUser.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
    }

    func updateUser(req: Request) throws -> EventLoopFuture<ServerUser> {
        let updatedUser = try req.content.decode(ServerUser.self)
        return ServerUser.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound)).flatMap { user in
                user.username = updatedUser.username
                user.email = updatedUser.email
                user.password = updatedUser.password
                return user.save(on: req.db).map { user }
            }
    }

    func deleteUser(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        ServerUser.find(req.parameters.get("userID"), on: req.db)
            .unwrap(or: Abort(.notFound))
            .flatMap { user in
                user.delete(on: req.db)
            }.transform(to: .ok)
    }
}
