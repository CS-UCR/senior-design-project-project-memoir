//
//  LoadSaveGeoAnchors.swift
//  ProjectM
//
//  Created by Carlos Loeza on 2/10/22.
//

import UIKit
import ARKit
//
//let GPXFileExtension = "gpx"
//
//extension ARViewController: GPXParserDelegate {
//    
//    
//    // MARK: - GPXParserDelegate
//    
//    func parser(_ parser: GPXParser, didFinishParsingFileWithAnchors anchors: [ARGeoAnchor]) {
//        
//        // Don't add geo anchors if geotracking isn't sure yet where the user is.
//        guard isGeoTrackingLocalized else {
//            alertUser(withTitle: "Cannot add geo anchor(s)", message: "Unable to add geo anchor(s) because geotracking has not yet localized.")
//            return
//        }
//        
//        if anchors.isEmpty {
//            alertUser(withTitle: "No anchors added", message: "GPX file does not contain anchors or is invalid.")
//            return
//        }
//        
//        for anchor in anchors {
//            addGeoAnchor(anchor)
//        }
//        
//        showToast("\(anchors.count) anchor(s) added.")
//    }
//}
