//
//  Network_UnitTest.swift
//  ProjectM_UnitTests
//
//  Created by Carlos Loeza on 3/3/22.
//

@testable import ProjectM
import XCTest


class Network_UnitTest: XCTestCase {
    func testListAnchors(){
        let expectation = self.expectation(description: "Fetching query")
        Network.shared.apollo.fetch(query: ListAnchorsQuery(limit: 1)) { result in
            defer{expectation.fulfill()}
            switch result {
            case .success(let graphQLResult):
                guard let items = graphQLResult.data?.listAnchors?.items else { break }
                XCTAssertEqual(items.count, 1)
                
            case .failure(_):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    func testGetAnchorData(){
        let anchorId = "38c3f92d-b987-488c-a299-490a2654d02b"
        let expectation = self.expectation(description: "Fetching query")
        Network.shared.apollo.fetch(query: GetAnchorByIdQuery(id: anchorId)) { result in
            defer{expectation.fulfill()}
            switch result {
            
            case .success(let graphQLResult):
                
                guard let anchorData = graphQLResult.data?.getAnchor
                else {
                    
                    break
                }
                let authorId = anchorData.authorId ?? "no author found"
                let message = anchorData.message ?? "no message found"
                XCTAssertNotNil(anchorData.authorId)
                XCTAssertNotNil(anchorData.message)
                
            case .failure(let error):
                XCTFail()
            }
        }
        self.waitForExpectations(timeout: 10, handler: nil)
    }
}


