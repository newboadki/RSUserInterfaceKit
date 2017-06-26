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
    var progress: Progress?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.progress = Progress(totalUnitCount: 100)
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
        
        let increment = arc4random_uniform(101) // [0, 100]
        let newValue = ((self.progress?.completedUnitCount)! + Int64(increment))
        if newValue >= (self.progress?.totalUnitCount)! {
            self.progress?.completedUnitCount = 100
        } else {
            self.progress?.completedUnitCount = newValue
        }

        self.circle.update(withProgress: self.progress!)
        self.label.text = String(format: "%.2f %%", ((self.progress?.fractionCompleted)! * 100.0))
        
        UIView.animate(withDuration: 0.1) {
            switch (self.progress?.fractionCompleted)!*100 {
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
        self.progress?.completedUnitCount = 0
        self.label.text = String(format: "%.2f %%", ((self.progress?.fractionCompleted)! * 100.0))
        self.label.textColor = UIColor.black
    }
}


