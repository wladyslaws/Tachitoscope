//
//  ViewController.swift
//  Tachitoscope
//
//  Created by Wladyslaw Surala on 11/05/2018.
//  Copyright © 2018 Wladyslaw Surala. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var labelTotalAttempts: UILabel!
    @IBOutlet weak var labelPositiveAttempts: UILabel!
    @IBOutlet weak var buttonStart: UIButton!
    @IBOutlet weak var labelTachitoscope: UILabel!
    @IBOutlet weak var labelCheck: UILabel!
    @IBOutlet weak var labelCheckReference: UILabel!
    @IBOutlet weak var labelTachitoscopeInterval: UILabel!
    @IBOutlet weak var textFieldTachitedNumber: UITextField!
    
    @IBOutlet weak var sliderTachitoscopeInterval: UISlider!
    
    @IBOutlet weak var stepperNumberOfDigits: UIStepper!
    @IBOutlet weak var labelNumberOfDigits: UILabel!
    
    @IBOutlet weak var labelPercentPositive: UILabel!
    
    var attemptsTotal = 0
    var attemptsPositive = 0
    
    var timeIntervalTachitoscope = 0.2
    var numberOfDigits = 8
    
    var textReference : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardShortcutForStart()
        sliderTachitoscopeInterval.value = Float(timeIntervalTachitoscope)
        stepperNumberOfDigits.value = Double(numberOfDigits)
        updateTachitoscopeIntervalView()
        updateNumberOfDigitsView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func changeTachitoscopeInterval(_ sender: Any) {
        timeIntervalTachitoscope = Double(sliderTachitoscopeInterval.value)
        updateTachitoscopeIntervalView()
    }
    @IBAction func updateNumberOfDigits(_ sender: Any) {
        numberOfDigits = Int(stepperNumberOfDigits.value)
        updateNumberOfDigitsView()
    }
    
    func updateTachitoscopeIntervalView() {
        let intervalString = String(format: "%.3f", timeIntervalTachitoscope)
        labelTachitoscopeInterval.text = "interval: " + intervalString
    }
    
    func updateNumberOfDigitsView() {
        let numberOfDigitsString = "Number of digits: \(numberOfDigits)"
        labelNumberOfDigits.text = numberOfDigitsString
    }
    
    func addKeyboardShortcutForStart() {
        let command = UIKeyCommand(input: "F", modifierFlags: UIKeyModifierFlags.command, action: #selector(ViewController.startTachitoscope), discoverabilityTitle: "Fire tachitoscope:")
        
        addKeyCommand(command)
    }
    
    @IBAction func startTachitoscope() {
        labelTachitoscope.alpha = 0
        var stringTachited = ""
        for _ in 1...numberOfDigits {
            stringTachited += randomDigit()
        }
        textReference = stringTachited
        labelTachitoscope.text = stringTachited
        labelTachitoscope.alpha = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + timeIntervalTachitoscope) {
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
        showResult(for: (textField.text != nil) ? textField.text! : "")
        textField.text = nil
        return false
    }
    
    func showResult(for typedText: String) {
        let resultString = compareTexts(reference: textReference, typed: typedText)
        labelCheck.attributedText = resultString
        labelCheckReference.text = textReference
        updateResults(for: typedText)
    }
    
    func updateResults(for typedText: String) {
        if textReference == typedText {
            attemptsPositive += 1
        }
        attemptsTotal += 1
        labelTotalAttempts.text = "total: \(attemptsTotal)"
        labelPositiveAttempts.text = "correct: \(attemptsPositive)"
        labelPercentPositive.text = "percent correct: \(Float(attemptsPositive)/Float(attemptsTotal))"
    }
    
    func compareTexts(reference: String, typed: String) -> NSAttributedString {
        let attributedString = zip(reference, typed).map {($1, $0 == $1)}.reduce(NSMutableAttributedString(string: "")) { (result, tupleCharacter) -> NSMutableAttributedString in
            
            let characterBackgroundColor = tupleCharacter.1 ? UIColor.green : UIColor.red
            
            let attrStringChar = NSMutableAttributedString(string: String(tupleCharacter.0), attributes: [NSAttributedStringKey.backgroundColor: characterBackgroundColor])
            result.append(attrStringChar)
            return result
        }
        let typedCount = typed.count
        let referenceCount = reference.count
        let overCount = typedCount - referenceCount
        if overCount > 0 {
            let overString = typed.suffix(overCount)
            let attrStringChar = NSMutableAttributedString(string: String(overString), attributes: [NSAttributedStringKey.backgroundColor: UIColor.red])
            attributedString.append(attrStringChar)
        }

        return attributedString
    }
    
}

