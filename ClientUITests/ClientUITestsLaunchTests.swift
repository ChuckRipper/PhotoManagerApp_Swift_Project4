//
//  ClientUITestsLaunchTests.swift
//  ClientUITests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class ClientUITestsLaunchTests: XCTestCase {
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
        
        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
