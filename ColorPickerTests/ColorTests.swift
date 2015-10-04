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

    func testIsValidInput() {
        let color = Color()
        XCTAssertTrue(color.isValidInput(0))
        XCTAssertTrue(color.isValidInput(100))
        XCTAssertTrue(color.isValidInput(13))
        XCTAssertFalse(color.isValidInput(255))
    }
}
