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
    var letterYo: String! = "a"
    
    var letterLabels: [UILabel] = [UILabel]()
    var randomLabel : UILabel! = nil
    override func viewDidLoad() {
        timeIntervalTachitoscope = 2.0
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction override func startTachitoscope() {

  
        textReference = randomString(length: numberOfDigits)
        self.addCircularLetterLabels()
        self.randomLabel =  letterLabels.randomElement()!
        letterYo = self.randomLabel.text!
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope) { [weak self] () -> Void in
            self!.clear(self as Any)
            self?.randomLabel.text = ""
            self?.randomLabel.backgroundColor = UIColor.systemBlue
            self!.view.addSubview(self!.randomLabel)
            self!.textReference = self!.letterYo
            self!.startCheck()
        }
        
    }
    
    func addCircularLetterLabels() {
        let radius = Float(80)
        print(textReference)
        let center = self.view.center
        let angleStep = 2 * Float.pi / Float(self.numberOfDigits)
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
            letterLabels.append(label)
            self.view.addSubview(label)
            
        }
    }

    @IBAction func clear(_ sender: Any) {
        letterLabels.forEach { (label) in
            label.removeFromSuperview()
        }
        letterLabels.removeAll()
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
        self.randomLabel.removeFromSuperview()
        self.updateNumberOfDigitsView()
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyz"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
