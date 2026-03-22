import XCTest
@testable import Pastel

class PastelTests: XCTestCase {

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
}
