//
//  ViewControllerLetterSpanTask.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 18/02/2020.
//  Copyright © 2020 Wladyslaw Surala. All rights reserved.
//

import Foundation

//
//  ViewControllerBackwardDigitSpan.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 22/10/2019.
//  Copyright © 2019 Wladyslaw Surala. All rights reserved.
//

import UIKit

class ViewControllerLetterSpanTask: ViewController {
    
    var consecutiveWins = 0
    var consecutiveLoses = 0
    
    var letterLabels: [UILabel] = [UILabel]()
    
    override func viewDidLoad() {
        timeIntervalTachitoscope = 1.0
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func startTachitoscope() {

        var stringTachited = randomString(length: numberOfDigits)
  
        textReference = stringTachited
        self.addCircularLetterLabels()
//        for i in 1...numberOfDigits {
//            guard let e = stringTachited.popLast() else {
//                print("gowno")
//                return
//            }
//            print(e)
//            print("sraka ", i)
//            let ch = String(e)
//            DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope*Double(i)) { [weak self] () -> Void in
//                self?.labelTachitoscope.text = ch
//            }
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope*Double(numberOfDigits+1)) {
//            [weak self] in
//            self?.labelTachitoscope.alpha = 0
//            self?.startCheck()
//        }
        
    }
    
    func addCircularLetterLabels() {
        let radius = Float(80)
        print(textReference)
        let center = self.view.center
        let angleStep = 360.0 / Float(self.numberOfDigits - 1)
        print(String(angleStep))
        for (n,c) in textReference!.enumerated() {
            let angle = angleStep * Float(n)
            let addY = -sin(angle) * radius
            let addX = cos(angle) * radius
            print("\(angle)")
            let pointLabel = CGPoint(x: Double(Float(center.x) + addX), y: Double(Float(center.y) + addY))
            let label = UILabel(frame: CGRect(origin: pointLabel, size: CGSize(width: 20, height: 20)))
            label.text = String(c)
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.black
            self.view.addSubview(label)
            
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
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
