//
//  Color.swift
//  ColorPicker
//
//  Created by Pengyu Wang on 10/3/15.
//  Copyright © 2015 Pengyu Wang. All rights reserved.
//

import Foundation
import UIKit

class Color {

    static let redType = 1
    static let greenType = 2
    static let blueType = 3

    enum InputError: ErrorType {
        case InputOutOfRange(badInput: Float)
        case InputIsEmpty
    }

    var red: Float = 0
    var green: Float = 0
    var blue: Float = 0

    var color: UIColor {
        get {
            return UIColor(
                red: CGFloat(self.red / 100),
                green: CGFloat(self.green / 100),
                blue: CGFloat(self.blue / 100),
                alpha: 1.0
            )
        }
    }

    init() {
        self.red = 0
        self.green = 0
        self.blue = 0
    }

    func setValue(type: Int, value: Float?) throws {

        guard colorComponentValueIsNotEmpty(value) else {
            throw InputError.InputIsEmpty
        }

        guard colorComponentValueIsInValidRange(value!) else {
            throw InputError.InputOutOfRange(badInput: value!)
        }

        switch type {
        case Color.redType:
            self.red = value!
        case Color.greenType:
            self.green = value!
        case Color.blueType:
            self.blue = value!
        default:
            print("Unknown type")
        }
    }

    func colorComponentValueIsNotEmpty(colorComponentValue: Float?) -> Bool {
        return colorComponentValue != nil
    }

    func colorComponentValueIsInValidRange(colorComponentValue: Float) -> Bool {
        return colorComponentValue <= 100 && colorComponentValue >= 0
    }
}
