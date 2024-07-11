//
//  ServerTests.swift
//  ServerTests
//
//  Created by user263923 on 7/9/24.
//

import XCTest
import Vapor
import Fluent
import XCTVapor

@testable import PhotoManagerApp_Swift_Project4

final class ServerTests: XCTestCase {

//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
    var app: Application!

    override func setUpWithError() throws {
        try super.setUpWithError()
        app = Application(.testing)
        try configure(app)
    }
    
    override func tearDownWithError() throws {
        app.shutdown()
        try super.tearDownWithError()
    }
    
    func configure(_ app: Application) throws {
        app.databases.use(.sqlite(.memory), as: .sqlite)
        app.migrations.add(CreateUser())
        app.migrations.add(CreateAlbum())
        app.migrations.add(CreatePhoto())
        app.migrations.add(CreateComment())
        try app.autoMigrate().wait()
    }
    
    func testUserCreation() throws {
        let user = ServerUser(username: "testuser", email: "test@example.com", password: "password")
        
        try app.test(.POST, "/users/register", beforeRequest: { req in
            try req.content.encode(user)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let returnedUser = try res.content.decode(ServerUser.self)
            XCTAssertEqual(returnedUser.username, "testuser")
            XCTAssertEqual(returnedUser.email, "test@example.com")
        })
    }
    
    func testPhotoCreation() throws {
        //let photo = Photo(title: "Test Photo", url: "http://example.com/photo.jpg", albumID: UUID())
        let photo = ServerPhoto(title: "Test Photo", url: "http://example.com/photo.jpg", albumId: UUID())
        
        try app.test(.POST, "/photos", beforeRequest: { req in
            try req.content.encode(photo)
        }, afterResponse: { res in
            XCTAssertEqual(res.status, .ok)
            let returnedPhoto = try res.content.decode(ServerPhoto.self)
            XCTAssertEqual(returnedPhoto.title, "Test Photo")
            XCTAssertEqual(returnedPhoto.url, "http://example.com/photo.jpg")
        })
    }
    
    
}
