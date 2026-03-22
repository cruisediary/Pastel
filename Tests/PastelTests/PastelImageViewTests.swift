import XCTest
@testable import Pastel

class PastelImageViewTests: XCTestCase {

    func testMaskIsImageView() {
        let view = PastelImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        XCTAssertTrue(view.mask is UIImageView)
    }

    func testMaskFrameMatchesBounds() {
        let view = PastelImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.layoutSubviews()
        let maskFrame = (view.mask as? UIImageView)?.frame
        XCTAssertEqual(maskFrame, view.bounds)
    }

    func testDefaultContentMode() {
        let view = PastelImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let maskContentMode = (view.mask as? UIImageView)?.contentMode
        XCTAssertEqual(maskContentMode, .scaleAspectFit)
    }

    func testImagePropagationToMask() {
        let view = PastelImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        let img = UIImage(systemName: "star.fill")
        view.image = img
        let maskImage = (view.mask as? UIImageView)?.image
        XCTAssertEqual(maskImage, img)
    }

    func testKeyframeAnimationPresent() {
        let view = PastelImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.setColors([.red, .blue])
        view.startAnimation()
        let gradientLayer = view.layer.sublayers?.compactMap { $0 as? CAGradientLayer }.first
        XCTAssertTrue(gradientLayer?.animation(forKey: "ColorChange") is CAKeyframeAnimation)
    }
}
