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

    func testKeyframeAnimationUsed() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.startAnimation()
        let anim = view.layer.sublayers?
            .compactMap { $0 as? CAGradientLayer }
            .first?
            .animation(forKey: "ColorChange")
        XCTAssertTrue(anim is CAKeyframeAnimation, "Expected CAKeyframeAnimation, got \(type(of: anim))")
    }

    func testKeyframeValuesCount() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.setColors([.red, .green, .blue])
        view.startAnimation()
        let gradientLayer = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first
        let anim = gradientLayer?.animation(forKey: "ColorChange") as? CAKeyframeAnimation
        XCTAssertEqual(anim?.values?.count, 4, "Expected 4 keyframe values (n + 1 wrap), got \(anim?.values?.count ?? -1)")
    }

    func testRepeatCountForever() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let state = PastelAnimationState(colors: [.red, .blue], repeatBehavior: .forever)
        view.animationState = state
        view.startAnimation()
        let gradientLayer = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first
        let anim = gradientLayer?.animation(forKey: "ColorChange") as? CAKeyframeAnimation
        XCTAssertEqual(anim?.repeatCount, .infinity, "Expected repeatCount == .infinity for .forever")
    }

    func testRepeatCountFinite() {
        let view = PastelView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let state = PastelAnimationState(colors: [.red, .blue], repeatBehavior: .count(3))
        view.animationState = state
        view.startAnimation()
        let gradientLayer = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first
        let anim = gradientLayer?.animation(forKey: "ColorChange") as? CAKeyframeAnimation
        XCTAssertEqual(anim?.repeatCount, 3.0, "Expected repeatCount == 3.0 for .count(3)")
    }
}
