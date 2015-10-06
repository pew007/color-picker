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

        redTextField.delegate = self
        redTextField.keyboardType = .DecimalPad

        greenTextField.delegate = self
        greenTextField.keyboardType = .DecimalPad

        blueTextField.delegate = self
        blueTextField.keyboardType = .DecimalPad

        let singleInstance = UIApplication.sharedApplication()
        let appDelegate = singleInstance.delegate as? AppDelegate

        color = (appDelegate?.color)!
        colorView.backgroundColor = color.color

//        NSNotificationCenter.defaultCenter().addObserver(self,
//            selector: "applicationDidEnterBackground",
//            name: UIApplicationDidEnterBackgroundNotification,
//            object: color
//        )
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "applicationWillTerminate",
            name: UIApplicationWillTerminateNotification,
            object: color
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
