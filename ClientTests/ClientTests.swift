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

    override func setUpWithError() throws {
        try super.setUpWithError()
        userViewModel = UserViewModel()
        photoViewModel = PhotoViewModel()
    }
    
    override func tearDownWithError() throws {
        userViewModel = nil
        photoViewModel = nil
        try super.tearDownWithError()
    }

    override func setUp() {
        // Dodatkowe ustawienia przed każdym testem
    }

    override func tearDown() {
        // Dodatkowe czynności po każdym teście
    }
    
    func testFetchUsers() throws {
        let expectation = self.expectation(description: "Fetch Users")
        userViewModel.fetchUsers()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.userViewModel.users.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchPhotos() throws {
        let expectation = self.expectation(description: "Fetch Photos")
        photoViewModel.fetchPhotos()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.photoViewModel.photos.isEmpty)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testUserViewModelInitialization() {
        XCTAssertNotNil(userViewModel)
    }

    func testPhotoViewModelInitialization() {
        XCTAssertNotNil(photoViewModel)
    }
}
