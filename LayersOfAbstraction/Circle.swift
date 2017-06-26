//
//  Circle.swift
//  LayersOfAbstraction
//
//  Created by Borja Arias Drake on 24/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics




@IBDesignable class CircularProgressIndicatorView: UIView {
    
    private var shapeLayer: CAShapeLayer?
    
    private(set) var fractionCompleted: Double = 0.0
    private(set) var previousFractionCompleted: Double = 0.0
        
    @IBInspectable var strokeColor: UIColor = .blue {
        didSet {
            self.shapeLayer?.strokeColor = strokeColor.cgColor
        }
    }

    @IBInspectable var fillColor: UIColor = .clear {
        didSet {
            self.shapeLayer?.fillColor = fillColor.cgColor
        }
    }

    
    required init?(frame: CGRect, strokeColor:UIColor, fillColor:UIColor) {
        super.init(frame: frame)
    }
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func createLayer(withFrame frame: CGRect, strokeColor:CGColor, fillColor:CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        layer.frame = frame
        
        // Create circle path
        let arcCenter = layer.position
        let radius = layer.bounds.size.width / 4.0
        let startAngle = CGFloat(-(Double.pi/2.0))
        let endAngle = CGFloat(3.0/2.0 * Double.pi)
        let clockwise = true
        
        let circlePath = UIBezierPath(arcCenter: arcCenter,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: clockwise)
        
        layer.path = circlePath.cgPath
        layer.strokeColor = strokeColor
        layer.fillColor = fillColor
        layer.lineWidth = frame.size.height/2.0
        layer.strokeEnd = 0.0
        return layer
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.shapeLayer == nil {
            shapeLayer = self.createLayer(withFrame: self.bounds, strokeColor: self.strokeColor.cgColor, fillColor: UIColor.clear.cgColor)
            self.layer.addSublayer(shapeLayer!)
        }
    }
    
    public func update(withProgress progress: Progress) {
        let delta = abs(self.fractionCompleted - progress.fractionCompleted)
        if (self.fractionCompleted + delta) <= 1.0 {
            self.fractionCompleted += delta
        } else {
            self.fractionCompleted = 1.0
        }

        self.animateInTransaction(amount: CGFloat(self.fractionCompleted), delta: delta)
    }
    
    private func animateInTransaction(amount: CGFloat, delta: Double) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(Swift.max(0.2, delta*1.0))
        self.shapeLayer?.strokeEnd = CGFloat(amount)
        CATransaction.commit()
    }
    
    public func reset() {
        self.fractionCompleted = 0
        self.previousFractionCompleted = 0
        CATransaction.setDisableActions(true)
        self.shapeLayer?.strokeEnd = CGFloat(self.fractionCompleted)
        CATransaction.setDisableActions(false)
    }
}

