//
//  ViewController.swift
//  ColorPicker
//
//  Created by Pengyu Wang on 9/30/15.
//  Copyright © 2015 Pengyu Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var red: UITextField!
    @IBOutlet weak var green: UITextField!
    @IBOutlet weak var blue: UITextField!

    @IBAction func changeColor(sender: UIButton) {
        print("Red: \(red!.text)")
        print("Red: \(green!.text)")
        print("Red: \(blue!.text)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

