//
//  ViewController.swift
//  LayersOfAbstraction
//
//  Created by Borja Arias Drake on 24/06/2017.
//  Copyright © 2017 Borja Arias Drake. All rights reserved.
//

import UIKit

import CoreGraphics





class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var circle: CircularProgressIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)

        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (timer) in
            DispatchQueue.main.async {
                self.buttonTapped(self)
            }
        }
    }

    @IBAction func buttonTapped(_ sender: Any) {
        let increment = CGFloat(Float(arc4random()) / Float(UINT32_MAX))

        self.circle.update(withDelta: increment)
        self.label.text = String(format: "%.2f %%", (self.circle.progress * 100.0))
        
        UIView.animate(withDuration: 0.1) {
            switch self.circle.progress*100 {
            case 0...10:
                self.label.textColor = UIColor.red
            case 10...20:
                self.label.textColor = UIColor.orange
            case 21...30:
                self.label.textColor = UIColor.yellow
            case 31...75:
                self.label.textColor = UIColor.purple
            case 76...99:
                self.label.textColor = UIColor.blue
            case 100:
                self.label.textColor = UIColor.green
            default:
                self.label.textColor = UIColor.red
            }
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.circle.reset()
        self.label.text = String(format: "%.2f %%", (self.circle.progress * 100.0))
        self.label.textColor = UIColor.black
    }
}


