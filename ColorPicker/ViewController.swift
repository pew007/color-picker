//
//  ViewController.swift
//  ColorPicker
//
//  Created by Pengyu Wang on 9/30/15.
//  Copyright © 2015 Pengyu Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var colorView: UIView!


    @IBAction func changeColor(sender: UIButton) {

        let redValue   = Float(redTextField!.text!)!
        let greenValue = Float(greenTextField!.text!)!
        let blueValue  = Float(blueTextField!.text!)!

        let newColor   = UIColor(
            red: CGFloat(redValue),
            green: CGFloat(greenValue),
            blue: CGFloat(blueValue),
            alpha: 1.0
        )

        colorView.backgroundColor = newColor
    }

    func isValidInput(value: Float) -> Bool {
        return value >= 0 && value <= 100
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        redTextField.delegate = self
        redTextField.keyboardType = .NumbersAndPunctuation

        greenTextField.delegate = self
        greenTextField.keyboardType = .NumbersAndPunctuation

        blueTextField.delegate = self
        blueTextField.keyboardType = .NumbersAndPunctuation

        colorView.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
