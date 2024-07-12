//
//  ClientTests.swift
//  ClientTests
//
//  Created by user263923 on 7/9/24.
//

import XCTest

@testable import PhotoManagerApp_Swift_Project4

final class ClientTests: XCTestCase {
    
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
