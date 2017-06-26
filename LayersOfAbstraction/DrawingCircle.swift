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


@IBDesignable class DrawingCircle: UIView {
    
//    var shapeLayer: CAShapeLayer?
    
    @IBInspectable var strokeColor: UIColor = .blue {
        
        didSet {
            self.setNeedsDisplay()
        }
        
    }
//
//    @IBInspectable var borderWidth: CGFloat = 0 {
//        
//        didSet {
//            self.shapeLayer?.borderWidth = borderWidth
//        }
//        
//    }
//    
//    @IBInspectable var fillColor: UIColor = .clear {
//        
//        didSet {
//            print("did set fill color.b")
//            self.shapeLayer?.fillColor = fillColor.cgColor
//        }
//        
//    }
    
    
    required init?(frame: CGRect, strokeColor:UIColor, fillColor:UIColor) {
        super.init(frame: frame)
    }
    
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        
        let ctx = UIGraphicsGetCurrentContext()
        

        
        let color: UIColor = self.strokeColor
        
        let drect = self.bounds.insetBy(dx: 5, dy: 5)
        let bpath:UIBezierPath = UIBezierPath(rect: drect)
        
        color.set()
        bpath.stroke()
        
        ctx?.addEllipse(in: rect)
        UIColor.red.set()
        ctx?.strokeEllipse(in: rect)
    }
}
