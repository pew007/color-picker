//
//  ViewController.swift
//  ColorPicker
//
//  Created by Pengyu Wang on 9/30/15.
//  Copyright © 2015 Pengyu Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    let minValue = 0.0
    let maxValue = 100
    let inputIsEmptyMessage = "Input is empty"
    let unexpectedErrorMessage = "An unexpected error has occurred"

    var color: Color = Color()

    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!

    @IBOutlet weak var colorView: UIView!

    @IBAction func redSliderChanged(sender: UISlider) {
        redTextField.text = String(sender.value)
        updateColor()
    }

    @IBAction func greenSliderChanged(sender: UISlider) {
        greenTextField.text = String(sender.value)
        updateColor()
    }

    @IBAction func blueSliderChanged(sender: UISlider) {
        blueTextField.text = String(sender.value)
        updateColor()
    }

    @IBAction func redTextChanged(sender: UITextField) {
        if sender.text != "" {
            redSlider.value = Float(sender.text!)!
        } else {
            sender.text = String(minValue)
            showPopupAlert(inputIsEmptyMessage)
        }
    }

    @IBAction func greenTextChanged(sender: UITextField) {
        if sender.text != "" {
            greenSlider.value = Float(sender.text!)!
        } else {
            sender.text = String(minValue)
            showPopupAlert(inputIsEmptyMessage)
        }
    }

    @IBAction func blueTextChanged(sender: UITextField) {
        if sender.text != "" {
            blueSlider.value = Float(sender.text!)!
        } else {
            sender.text = String(minValue)
            showPopupAlert(inputIsEmptyMessage)
        }
    }

    @IBAction func changeColor(sender: UIButton) {
        // Hide keyboard
        self.view.endEditing(true)
        updateColor()
    }

    func updateColor() {
        let redValue   = Float(redTextField!.text!)
        let greenValue = Float(greenTextField!.text!)
        let blueValue  = Float(blueTextField!.text!)

        do {
            try color.setValue(Color.redType, value: redValue)
            try color.setValue(Color.greenType, value: greenValue)
            try color.setValue(Color.blueType, value: blueValue)
            colorView.backgroundColor = color.color
        } catch Color.InputError.InputOutOfRange(let badInput){
            showPopupAlert("Input \(badInput) is out of range (0-100)")
        } catch Color.InputError.InputIsEmpty {
            showPopupAlert(inputIsEmptyMessage)
        } catch {
            showPopupAlert(unexpectedErrorMessage)
        }
    }

    func showPopupAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        self.presentViewController(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setDecimalPadKeyboard()

        let userDefaults = NSUserDefaults.standardUserDefaults()
        let red = userDefaults.floatForKey("red")
        let green = userDefaults.floatForKey("green")
        let blue = userDefaults.floatForKey("blue")

        redTextField.text = String(red)
        greenTextField.text = String(green)
        blueTextField.text = String(blue)

        redSlider.value = red
        greenSlider.value = green
        blueSlider.value = blue

        do {
            try color.setValue(Color.redType, value: red)
            try color.setValue(Color.greenType, value: green)
            try color.setValue(Color.blueType, value: blue)
            colorView.backgroundColor = color.color
        } catch Color.InputError.InputOutOfRange(let badInput){
            showPopupAlert("Input \(badInput) is out of range (0-100)")
        } catch Color.InputError.InputIsEmpty {
            showPopupAlert(inputIsEmptyMessage)
        } catch {
            showPopupAlert(unexpectedErrorMessage)
        }

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationWillTerminate:",
            name: UIApplicationDidEnterBackgroundNotification,
            object: nil
        )
    }

    func setDecimalPadKeyboard() {
        redTextField.delegate = self
        redTextField.keyboardType = .DecimalPad

        greenTextField.delegate = self
        greenTextField.keyboardType = .DecimalPad

        blueTextField.delegate = self
        blueTextField.keyboardType = .DecimalPad
    }

    func applicationWillTerminate(notification: NSNotification) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(color.red, forKey: "red")
        userDefaults.setValue(color.green, forKey: "green")
        userDefaults.setValue(color.blue, forKey: "blue")
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
