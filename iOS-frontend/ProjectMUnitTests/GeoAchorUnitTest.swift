//
//  GeoAchorUnitTest.swift
//  ProjectMUnitTests
//
//  Created by Carlos Loeza on 3/9/22.
//


@testable import ProjectM
import XCTest
import ARKit

// class GeoAnchor_UnitTest contains the unit test for our Network
class GeoAnchorUnitTests: XCTestCase {
    // testAnchorNotNil checks to see if our anchor save the location assigned to it.
    // Helps validate all our of anchors will have a location when they are placed
    func testAnchorNotNil(){
        let location = CLLocationCoordinate2D(latitude: 100.0, longitude: 100.0)
        // Create a geoAnchor variable to assign it our location
        var geoAnchor: ARGeoAnchor!
        // Assign geoLocation
        geoAnchor = ARGeoAnchor(coordinate: location)
        // Make sure our geoAnchor contains coordinates
        XCTAssertNotNil(geoAnchor.coordinate)
    }
}
