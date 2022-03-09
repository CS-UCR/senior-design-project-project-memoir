//
//  Network_UnitTest.swift
//  ProjectM_UnitTests
//
//  Created by Carlos Loeza on 3/3/22.
//
/*
 
 - name: Select Xcode
       run: sudo xcode-select -switch /Applications/Xcode_12.2.app && /usr/bin/xcodebuild -version
     - name: Run unit tests
       run: xcodebuild test -scheme ProjectM -workspace ProjectM.xcodeproj
 */

@testable import ProjectM
import XCTest

// class Network_UnitTest contains the unit test for our Network
class Network_UnitTest: XCTestCase {
    // testListAnchors tests to see if we are able to recover items from our server.
    // We are makinga call to Apollo to get an one anchor from our server
    func testListAnchors(){
        let expectation = self.expectation(description: "Fetching query")
        Network.shared.apollo.fetch(query: ListAnchorsQuery(limit: 1)) { result in
            // defer{} works as a pause button. We will not run the switch statment
            // until defer{} is done.
            // We need this because our test case will run before the server is done getting the
            // the anchor
            defer{expectation.fulfill()}
            switch result {
            case .success(let graphQLResult):
                guard let items = graphQLResult.data?.listAnchors?.items else { break }
                // Test case
                XCTAssertEqual(items.count, 1)
                
            case .failure(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    // testGetAnchorData tests to see if the anchor has data attached to it
    func testGetAnchorData(){
        // anchorId lets us know what anchor to retrieve
        let anchorId = "38c3f92d-b987-488c-a299-490a2654d02b"
        let expectation = self.expectation(description: "Fetching query")
        Network.shared.apollo.fetch(query: GetAnchorByIdQuery(id: anchorId)) { result in
            defer{expectation.fulfill()}
            switch result {
            // if anchorId is found get anchorData, else break
            case .success(let graphQLResult):
                guard let anchorData = graphQLResult.data?.getAnchor
                else {
                    break
                }
                // retrive authorId and message
                let authorId = anchorData.authorId ?? "no author found"
                let message = anchorData.message ?? "no message found"
                // Test to make sure our values retrieved are not nil
                XCTAssertNotNil(anchorData.authorId)
                XCTAssertNotNil(anchorData.message)
            case .failure(let error):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}


