//
//  CustomElements.swift
//  ProjectM
//
//  Created by Richard Duong on 2/26/22.
//  A small helper library for creating ui elements and animations on the views / sublayers
//  Code referenced from:
//  https://stackoverflow.com/questions/31540375/how-to-create-a-toast-message-in-swift


import Foundation
import UIKit
import CoreLocation
import RealityKit

// a class that helps remove layers at the end of an animation call
// reference: https://stackoverflow.com/questions/17688440/how-to-remove-a-layer-when-its-animation-completes
class LayerRemover: NSObject, CAAnimationDelegate {
    private weak var layer: CALayer?

    init(for layer: CALayer) {
        self.layer = layer
        super.init()
    }

    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        layer?.removeFromSuperlayer()
    }
}

class CustomElements {

    // show click indicator on click
    static func clickIndicator(loc: CGPoint, startRadius: CGFloat, endRadius: CGFloat, controller: UIViewController, color: UIColor
    ) {
        
        let startCircle = UIBezierPath(ovalIn: CGRect(
            x: loc.x,
            y: loc.y,
            width: startRadius,
            height: startRadius))
        
        // in order to center the scale change, shift to left and up by (endRadius - startRadius / 2)
        let shift = (endRadius - startRadius) / 2
        let endCircle = UIBezierPath(ovalIn: CGRect(
            x: loc.x - shift,
            y: loc.y - shift,
            width: endRadius,
            height: endRadius))
        
        // move start circle path to shape layer
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = startCircle.cgPath
        shapeLayer.opacity = 0.0
        
        // modifiers for the shape
        shapeLayer.fillColor = color.withAlphaComponent(0.05).cgColor
        shapeLayer.strokeColor = color.withAlphaComponent(0.8).cgColor
        shapeLayer.lineWidth = 1.5
        
        // add shape layer to view
        controller.view.layer.addSublayer(shapeLayer)
        
        // create animations
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 1.0
        opacityAnimation.toValue = 0.0
        opacityAnimation.duration = 0.3
        opacityAnimation.isRemovedOnCompletion = true
        opacityAnimation.beginTime = CACurrentMediaTime()
        opacityAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        opacityAnimation.delegate = LayerRemover(for: shapeLayer)

        // animate the shape from startRadius to endRadius circle
        let shapeAnimation = CABasicAnimation(keyPath: "path")
        shapeAnimation.fromValue = startCircle.cgPath
        shapeAnimation.toValue = endCircle.cgPath
        shapeAnimation.duration = 0.3
        shapeAnimation.isRemovedOnCompletion = true
        shapeAnimation.beginTime = CACurrentMediaTime()
        shapeAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        // transact multiple animations together
        CATransaction.begin()
        shapeLayer.add(opacityAnimation, forKey: "opacity")
        shapeLayer.add(shapeAnimation, forKey: "path")
        CATransaction.commit()
    }
    
    // display a toast message on the screen
    static func toast(message: String, controller: UIViewController) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true
        toastContainer.layer.name = "toast - entity not found"

        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -75)
        controller.view.addConstraints([c1, c2, c3])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
