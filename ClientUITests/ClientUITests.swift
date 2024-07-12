//
//  ClientUITests.swift
//  ClientUITests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class ClientUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {}
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Test login button
        app.buttons["Login"].tap()
        XCTAssertTrue(app.staticTexts["Login"].exists)
        
        // Test register button
        app.navigationBars.buttons["Photo Manager"].tap()
        app.buttons["Register"].tap()
        XCTAssertTrue(app.staticTexts["Register"].exists)
    }
}
