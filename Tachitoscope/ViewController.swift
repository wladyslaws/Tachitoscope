//
//  ViewController.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 11/05/2018.
//  Copyright © 2018 Wladyslaw Surala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var labelTachitoscope: UILabel!
    @IBOutlet weak var labelCheck: UILabel!
    @IBOutlet weak var textFieldTachitedNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startTachitoscope(_ sender: Any) {
        labelTachitoscope.alpha = 0
        let numberOfDigits = 8
        var stringTachited = ""
        for _ in 1..<numberOfDigits {
            stringTachited += randomDigit()
        }
        labelTachitoscope.text = stringTachited
        labelTachitoscope.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1 ) {
            self.labelTachitoscope.alpha = 0
            self.startCheck()
        }
        
    }
    
    func startCheck() {
        textFieldTachitedNumber.becomeFirstResponder()
    }
    
    func randomDigit() -> String {
        let digit = arc4random_uniform(10)
        return "\(digit)"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        labelCheck.text = textField.text
        labelTachitoscope.alpha = 1
        return false
    }
    
}

