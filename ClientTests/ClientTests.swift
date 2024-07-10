//
//  ClientTests.swift
//  ClientTests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class ClientTests: XCTestCase {

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
    
    var userViewModel: UserViewModel!
    var photoViewModel: PhotoViewModel!

    override func setUp() {
        super.setUp()
        userViewModel = UserViewModel()
        photoViewModel = PhotoViewModel()
    }
    
    override func tearDown() {
        userViewModel = nil
        photoViewModel = nil
        super.tearDown()
    }
    
    func testFetchUsers() {
        let expectation = self.expectation(description: "Fetch Users")
        userViewModel.fetchUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.userViewModel.users.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchPhotos() {
        let expectation = self.expectation(description: "Fetch Photos")
        photoViewModel.fetchPhotos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.photoViewModel.photos.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
