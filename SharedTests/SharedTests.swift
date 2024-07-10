//
//  SharedTests.swift
//  SharedTests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class SharedTests: XCTestCase {

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
    
    func testUserFlow() throws {
           let app = XCUIApplication()
           app.launch()

           // Register a new user
           app.buttons["Register"].tap()
           let usernameField = app.textFields["Username"]
           let emailField = app.textFields["Email"]
           let passwordField = app.secureTextFields["Password"]

           usernameField.tap()
           usernameField.typeText("testuser")

           emailField.tap()
           emailField.typeText("test@example.com")

           passwordField.tap()
           passwordField.typeText("password")

           app.buttons["Register"].tap()

           // Login with the new user
           app.buttons["Login"].tap()
           usernameField.tap()
           usernameField.typeText("testuser")

           passwordField.tap()
           passwordField.typeText("password")

           app.buttons["Login"].tap()

           // Verify the user is logged in
           XCTAssertTrue(app.staticTexts["Welcome, testuser!"].exists)
       }
}
