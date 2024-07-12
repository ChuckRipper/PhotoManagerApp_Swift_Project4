//
//  SharedTests.swift
//  SharedTests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class SharedTests: XCTestCase {

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
