//
//  Entity.swift
//  ProjectM
//
//  Created by Bryan on 2/16/22.
//

import Foundation
import ARKit
import RealityKit

extension Entity {
    func move(by translation: SIMD3<Float>, scale: SIMD3<Float>, after delay: TimeInterval, duration: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            var transform: Transform = .identity
            transform.translation = self.transform.translation + translation
            transform.scale = self.transform.scale * scale
            self.move(to: transform, relativeTo: self.parent, duration: duration, timingFunction: .easeInOut)
        }
    }
    
    func randomScale() {
      var newTransform = self.transform
      newTransform.scale = .init(
        repeating: Float.random(in: 0.5...1.5)
      )
      self.transform = newTransform
    }
}
