//
//  ViewControllerBackwardDigitSpan.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 22/10/2019.
//  Copyright © 2019 Wladyslaw Surala. All rights reserved.
//

import UIKit

class ViewControllerBackwardDigitSpan: ViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func startTachitoscope() {
        labelTachitoscope.alpha = 0
        var stringTachited = ""
        for _ in 1...numberOfDigits {
            stringTachited += randomDigit()
        }
        textReference = stringTachited
        
        labelTachitoscope.alpha = 1
        for _ in numberOfDigits...1 {
            let ch = String(stringTachited.popLast()!)
            labelTachitoscope.text = ch
            sleep(UInt32(timeIntervalTachitoscope))
        }
        self.labelTachitoscope.alpha = 0
        self.startCheck()
        
    }
    
}
