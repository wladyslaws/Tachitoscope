//
//  ViewControllerBackwardDigitSpan.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 22/10/2019.
//  Copyright © 2019 Wladyslaw Surala. All rights reserved.
//

import UIKit

class ViewControllerBackwardDigitSpan: ViewController {
    
    var consecutiveWins = 0
    var consecutiveLoses = 0
    override func viewDidLoad() {
        timeIntervalTachitoscope = 1.0
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func startTachitoscope() {
        labelTachitoscope.text = ""
        labelTachitoscope.alpha = 0
        var stringTachited = ""
        for _ in 1...numberOfDigits {
            stringTachited += randomDigit()
        }
        textReference = stringTachited
        
        labelTachitoscope.alpha = 1
        for i in 1...numberOfDigits {
            guard let e = stringTachited.popLast() else {
                print("gowno")
                return
            }
            print(e)
            print("sraka ", i)
            let ch = String(e)
            DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope*Double(i)) { [weak self] () -> Void in
                self?.labelTachitoscope.text = ch
                self?.blinkBlinker()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope*Double(numberOfDigits+1)) {
            [weak self] in
            self?.labelTachitoscope.alpha = 0
            self?.startCheck()
        }
        
    }
    
    override func updateResults(for typedText: String) {
        super.updateResults(for: typedText)
        if typedText == textReference {
            consecutiveWins += 1
        } else {
            consecutiveLoses += 1
        }
        
        if consecutiveWins > 1 {
            numberOfDigits += 1
            consecutiveLoses = 0
            consecutiveWins = 0
        }
        
        if consecutiveLoses > 1 && numberOfDigits > 3 {
            numberOfDigits -= 1
            consecutiveLoses = 0
            consecutiveWins = 0
        }
        self.updateNumberOfDigitsView()
    }
    
}
