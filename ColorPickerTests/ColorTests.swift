//
//  ColorTests.swift
//  ColorPicker
//
//  Created by Pengyu Wang on 10/3/15.
//  Copyright © 2015 Pengyu Wang. All rights reserved.
//

import XCTest
@testable import ColorPicker

class ColorTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testColorComponentValueIsNotEmpty() {
        let color = Color()

        XCTAssertTrue(color.colorComponentValueIsNotEmpty(1.2))
        XCTAssertTrue(color.colorComponentValueIsNotEmpty(0))
        XCTAssertTrue(color.colorComponentValueIsNotEmpty(100))

        XCTAssertFalse(color.colorComponentValueIsNotEmpty(nil))
    }

    func testColorComponentValueIsInValidRange() {
        let color = Color()

        XCTAssertTrue(color.colorComponentValueIsInValidRange(0))
        XCTAssertTrue(color.colorComponentValueIsInValidRange(1.0))
        XCTAssertTrue(color.colorComponentValueIsInValidRange(32.5))
        XCTAssertTrue(color.colorComponentValueIsInValidRange(100))

        XCTAssertFalse(color.colorComponentValueIsInValidRange(-1))
        XCTAssertFalse(color.colorComponentValueIsInValidRange(101))
        XCTAssertFalse(color.colorComponentValueIsInValidRange(150))
        XCTAssertFalse(color.colorComponentValueIsInValidRange(255))
    }

    func testSetValue() {
        let color = Color()

        var expectedException: Color.InputError? = nil
        do {
            try color.setValue(Color.redType, value: nil)
        } catch Color.InputError.InputIsEmpty {
            expectedException = Color.InputError.InputIsEmpty
        } catch {
            print("Unexpected exception")
        }
        XCTAssertNotNil(expectedException, "Expected InputIsEmpty exception.")

        do {
            try color.setValue(Color.greenType, value: 255)
        } catch Color.InputError.InputOutOfRange(badInput: let badInput) {
            expectedException = Color.InputError.InputOutOfRange(badInput: badInput)
        } catch {
            print("Unexpected exception")
        }
        XCTAssertNotNil(expectedException, "Expected InputOutOfRange exception.")

        do {
            try color.setValue(Color.blueType, value: 20)
        } catch Color.InputError.InputOutOfRange(badInput: let badInput) {
            expectedException = Color.InputError.InputOutOfRange(badInput: badInput)
        } catch Color.InputError.InputIsEmpty {
            expectedException = Color.InputError.InputIsEmpty
        } catch {
            print("Unexpected exception")
        }
        XCTAssertEqual(color.blue, 20)
    }
}
