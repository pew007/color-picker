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

        // Hide keyboard
        self.view.endEditing(true)

        let redValue   = Float(redTextField!.text!)
        let greenValue = Float(greenTextField!.text!)
        let blueValue  = Float(blueTextField!.text!)

        do {
            let color = Color()
            try color.setValue(Color.redType, value: redValue)
            try color.setValue(Color.greenType, value: greenValue)
            try color.setValue(Color.blueType, value: blueValue)
            colorView.backgroundColor = color.color
        } catch Color.InputError.InputOutOfRange(let badInput){
            showPopupAlert("Input \(badInput) is out of range (0-100)")
        } catch Color.InputError.InputIsEmpty {
            showPopupAlert("Input is empty")
        } catch {
            showPopupAlert("An unexpected error has occurred")
        }
    }

    func showPopupAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        redTextField.delegate = self
        redTextField.keyboardType = .DecimalPad

        greenTextField.delegate = self
        greenTextField.keyboardType = .DecimalPad

        blueTextField.delegate = self
        blueTextField.keyboardType = .DecimalPad

        colorView.backgroundColor = UIColor.blackColor()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
