//
//  SIMD.swift
//  AR_Message
//
//  Created by Carlos Loeza on 12/2/21.
//

import Foundation

// we need to turn SIMD4 vector into a SIMD3 vector
extension SIMD4 {
    // making our SIMD3 a <Scalar> allows us to keep the type
    // as whatever called xyz below
    var xyz: SIMD3<Scalar> {
        return self[SIMD3(0, 1, 2)]
    }
}
