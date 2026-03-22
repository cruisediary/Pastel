//
//  PastelTests.swift
//  PastelTests
//
//  Created by CruzDiary on 14/05/2017.
//  Copyright © 2017 Cruz. All rights reserved.
//

import XCTest
@testable import Pastel

class PastelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPastelPointPublicAccess() {
        // Validates that topRight maps to the correct CGPoint.
        // Note: @testable import bypasses access control; value correctness is what's verified here.
        let pt = PastelPoint.topRight.point
        XCTAssertEqual(pt, CGPoint(x: 1.0, y: 0.0))
    }

    func testTimingCurveMapsToCA() {
        XCTAssertEqual(PastelTimingCurve.linear.caTimingFunction, .linear)
        XCTAssertEqual(PastelTimingCurve.easeIn.caTimingFunction, .easeIn)
        XCTAssertEqual(PastelTimingCurve.easeOut.caTimingFunction, .easeOut)
        XCTAssertEqual(PastelTimingCurve.easeInOut.caTimingFunction, .easeInEaseOut)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
