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
    
    private(set) var progress: CGFloat = 0.0
        
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
    
    public func update(withDelta delta: CGFloat) {
        if self.progress + delta <= 1.0 {
            self.progress += delta
        } else {
            self.progress = 1.0
        }

        self.animateInTransaction(amount: self.progress)
    }
    
    private func animateInTransaction(amount: CGFloat) {
        let currentProgress = self.progress
        self.progress = amount
        CATransaction.begin()
        let delta = (fabs(Double(self.progress - currentProgress)))
        CATransaction.setAnimationDuration(Swift.max(0.2, delta*1.0))
        self.shapeLayer?.strokeEnd = self.progress
        CATransaction.commit()
    }
    
    public func reset() {
        self.progress = 0
        CATransaction.setDisableActions(true)
        self.shapeLayer?.strokeEnd = self.progress
        CATransaction.setDisableActions(false)
    }
}

