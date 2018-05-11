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
    @IBOutlet weak var labelCheckReference: UILabel!
    @IBOutlet weak var textFieldTachitedNumber: UITextField!
    
    var textReference : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardShortcutForStart()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addKeyboardShortcutForStart() {
        let command = UIKeyCommand(input: "F", modifierFlags: UIKeyModifierFlags.command, action: #selector(ViewController.startTachitoscope), discoverabilityTitle: "Fire tachitoscope:")
        
        addKeyCommand(command)
    }
    
    @IBAction func startTachitoscope() {
        labelTachitoscope.alpha = 0
        let numberOfDigits = 8
        var stringTachited = ""
        for _ in 1..<numberOfDigits {
            stringTachited += randomDigit()
        }
        textReference = stringTachited
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
        labelCheckReference.text = textReference
        return false
    }
    
}

