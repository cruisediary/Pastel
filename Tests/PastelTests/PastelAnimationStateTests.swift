import XCTest
@testable import Pastel

class PastelAnimationStateTests: XCTestCase {

    func testDefaultValues() {
        let state = PastelAnimationState(colors: [.red, .blue])
        XCTAssertEqual(state.duration, 5.0)
        XCTAssertEqual(state.autoreverses, false)
        XCTAssertEqual(state.startPoint, CGPoint(x: 1, y: 0))
        XCTAssertEqual(state.endPoint, CGPoint(x: 0, y: 1))
    }

    func testPreconditionMinTwoColors() {
        let state = PastelAnimationState(colors: [.red, .blue])
        XCTAssertEqual(state.colors.count, 2)
    }

    func testRepeatBehaviorForever() {
        let state = PastelAnimationState(colors: [.red, .blue], repeatBehavior: .forever)
        if case .forever = state.repeatBehavior { } else {
            XCTFail("Expected .forever")
        }
    }

    func testRepeatBehaviorCount() {
        let state = PastelAnimationState(colors: [.red, .blue], repeatBehavior: .count(3))
        if case .count(let n) = state.repeatBehavior {
            XCTAssertEqual(n, 3)
        } else {
            XCTFail("Expected .count(3)")
        }
    }
}
