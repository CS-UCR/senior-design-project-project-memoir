//
//  Utilities.swift
//  ProjectM
//
//  Created by Bryan on 1/16/22.
//

import ARKit
import RealityKit

// Get the position portion of the 4x4 matrix
// (1, 0, 0, *)
// (0, 1, 0, *)
// (0, 0, 1, *)
// (x, y, z, *) <- the position
extension simd_float4x4 {
    var translation: SIMD3<Float> {
        get {
            return SIMD3<Float>(columns.3.x, columns.3.y, columns.3.z)
        }
        set (newValue) {
            columns.3.x = newValue.x
            columns.3.y = newValue.y
            columns.3.z = newValue.z
        }
    }
}


extension Entity {
    
}
