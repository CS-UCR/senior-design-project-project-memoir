//
//  GeoAnchor.swift
//  ProjectM_UnitTests
//
//  Created by Carlos Loeza on 3/6/22.
//

import XCTest
@testable import ProjectM
import CoreLocation
import ARKit

class GeoAnchor_UnitTests: XCTestCase {

    func testocationForGeoAnchor(){
        let geoAnchor = ARViewController()
        
        let location = CLLocationCoordinate2D(latitude: 100.0, longitude: 100.0)
        
        XCTAssertNotNil(geoAnchor.addGeoLocationToAnchor(at: location, altitude: 0))
        
    }

//    func testAnchor(){
//        let controller = ARViewController()
//        
//        let anchor: ARGeoAnchor
//        anchor.coordinate
//        controller.prepareToAddGeoAnchor(<#T##geoAnchor: ARGeoAnchor##ARGeoAnchor#>)
//    }
}
