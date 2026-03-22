import XCTest
@testable import Pastel

class PastelPointTests: XCTestCase {

    func testAllPointMappings() {
        XCTAssertEqual(PastelPoint.left.point,        CGPoint(x: 0.0, y: 0.5))
        XCTAssertEqual(PastelPoint.top.point,         CGPoint(x: 0.5, y: 0.0))
        XCTAssertEqual(PastelPoint.right.point,       CGPoint(x: 1.0, y: 0.5))
        XCTAssertEqual(PastelPoint.bottom.point,      CGPoint(x: 0.5, y: 1.0))
        XCTAssertEqual(PastelPoint.topLeft.point,     CGPoint(x: 0.0, y: 0.0))
        XCTAssertEqual(PastelPoint.topRight.point,    CGPoint(x: 1.0, y: 0.0))
        XCTAssertEqual(PastelPoint.bottomLeft.point,  CGPoint(x: 0.0, y: 1.0))
        XCTAssertEqual(PastelPoint.bottomRight.point, CGPoint(x: 1.0, y: 1.0))
    }
}
