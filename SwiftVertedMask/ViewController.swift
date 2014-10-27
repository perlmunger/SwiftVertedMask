//
//  ViewController.swift
//  SwiftVertedMask
//
//  Created by Matt Long on 10/27/14.
//  Copyright (c) 2014 Skye Road Systems. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.applyMask()
    }

    func applyMask() {
        
        let mainLayer = CALayer()
        mainLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        mainLayer.position = CGPoint(x: 200.0, y: 200.0)
        mainLayer.backgroundColor = UIColor.orangeColor().CGColor
        
        self.view.layer.addSublayer(mainLayer)
        
        let radius = 50 as CGFloat
        let width = 50 as CGFloat
        
        let origin = CGPointMake(0, 100)
        let end = CGPointMake(100,100)
        let highAmplitude = CGPointMake(50,180)
        let lowAmplitude = CGPointMake(50,150)
        
        let quad = UIBezierPath()
        quad.moveToPoint(origin)
        quad.addQuadCurveToPoint(end, controlPoint: highAmplitude)
        quad.closePath()
        
        let quad2 = UIBezierPath()
        quad2.moveToPoint(origin)
        quad2.addQuadCurveToPoint(end, controlPoint: lowAmplitude)
        quad2.closePath()
        
        let layer = CAShapeLayer()
        layer.path = quad.CGPath
        
        layer.strokeColor = UIColor.greenColor().CGColor
        layer.fillColor = UIColor.blackColor().CGColor
        
        mainLayer.addSublayer(layer)
        
        let anim =  CABasicAnimation(keyPath: "path")
        anim.duration = 3
        anim.repeatCount = 20
        anim.fromValue = quad.CGPath
        anim.toValue = quad2.CGPath
        anim.autoreverses = true
        layer.addAnimation(anim, forKey: "animQuad")
        
        let animRotate =  CABasicAnimation(keyPath: "transform.rotation")
        animRotate.duration = 5
        animRotate.repeatCount = 20
        animRotate.fromValue = 0
        animRotate.toValue = 360 * CGFloat(M_PI) / 180
        mainLayer.addAnimation(animRotate, forKey: "animRotate")
        
        // Build a Circle CGPath
        var circlePath = CGPathCreateMutable()
        CGPathAddEllipseInRect(circlePath, nil, CGRectInset(mainLayer.bounds, -20.0, -20.0))
        // Invert the mask by adding a bounding rectangle
        CGPathAddRect(circlePath, nil, CGRectInset(mainLayer.bounds, -100.0, -100.0))
        CGPathCloseSubpath(circlePath)
        
        // View this in the debugger to see the actual path
        var bPath = UIBezierPath(CGPath: circlePath)
        
        let circleLayer = CAShapeLayer()
        circleLayer.fillColor = UIColor.blueColor().CGColor
        circleLayer.opacity = 0.6
        // Use the even odd fill rule so that our path gets inverted
        circleLayer.fillRule = kCAFillRuleEvenOdd
        circleLayer.path = circlePath
        
        mainLayer.mask = circleLayer

        mainLayer.addSublayer(layer)
    }

}

