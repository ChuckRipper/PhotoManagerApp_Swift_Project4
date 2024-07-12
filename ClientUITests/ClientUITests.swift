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
        try super.setUpWithError()
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app.shutdown()
        try super.tearDownWithError()
    }

    override func setUp() {
        // Dodatkowe ustawienia przed każdym testem
    }

    override func tearDown() {
        // Dodatkowe czynności po każdym teście
    }
    
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        
        // Testowanie przycisku "Login"
        app.buttons["Login"].tap()
        XCTAssertTrue(app.staticTexts["Login"].exists)
        
        // Testowanie przycisku "Register"
        app.navigationBars.buttons["Photo Manager"].tap()
        app.buttons["Register"].tap()
        XCTAssertTrue(app.staticTexts["Register"].exists)
    }

    func testLaunchPerformance() throws {
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
