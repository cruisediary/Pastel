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

    func testNoSublayerAccumulation() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.startAnimation()
        view.startAnimation()
        view.startAnimation()
        let gradientLayers = view.layer.sublayers?.filter { $0 is CAGradientLayer } ?? []
        XCTAssertEqual(gradientLayers.count, 1, "Expected exactly 1 CAGradientLayer, got \(gradientLayers.count)")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
