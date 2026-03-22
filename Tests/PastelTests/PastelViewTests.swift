import XCTest
@testable import Pastel

class PastelViewTests: XCTestCase {

    func testNoSublayerAccumulation() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.startAnimation()
        view.startAnimation()
        view.startAnimation()
        let gradientLayers = view.layer.sublayers?.filter { $0 is CAGradientLayer } ?? []
        XCTAssertEqual(gradientLayers.count, 1, "Expected exactly 1 CAGradientLayer, got \(gradientLayers.count)")
    }

    func testAnimationStateOverridesProperties() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let state = PastelAnimationState(
            colors: [.red, .blue],
            duration: 2.0,
            startPoint: CGPoint(x: 0, y: 0),
            endPoint: CGPoint(x: 1, y: 1)
        )
        view.animationState = state
        view.startAnimation()
        let gradientLayer = view.layer.sublayers?.first(where: { $0 is CAGradientLayer }) as? CAGradientLayer
        XCTAssertNotNil(gradientLayer)
        XCTAssertEqual(gradientLayer?.startPoint, CGPoint(x: 0, y: 0))
        XCTAssertEqual(gradientLayer?.endPoint, CGPoint(x: 1, y: 1))
    }
}
