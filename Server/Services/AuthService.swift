//
//  AuthService.swift
//  PhotoManagerApp_Swift_Project4
//
//  Created by user263923 on 7/9/24.
//

import Foundation
import Vapor
import Fluent

//struct AuthService {
//    // Implement authentication methods
//}

final class AuthService {
    
    // Rejestracja nowego użytkownika
    func register(req: Request) throws -> EventLoopFuture<ServerUser> {
        var user = try req.content.decode(ServerUser.self)
        user.password = try Bcrypt.hash(user.password)
        return user.save(on: req.db).map { user }
    }
    
    // Logowanie użytkownika
    func login(req: Request) throws -> EventLoopFuture<ServerUser> {
        var user = try req.content.decode(ServerUser.self)
        
        return ServerUser.query(on: req.db)
            .filter(\.$email == user.email)
            .first()
            .unwrap(or: Abort(.notFound))
            .flatMapThrowing { foundUser in
                if try Bcrypt.verify(user.password, created: foundUser.password) {
                    return foundUser
                } else {
                    throw Abort(.unauthorized)
                }
            }
    }
}
