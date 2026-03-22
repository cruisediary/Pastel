import XCTest
@testable import Pastel

class PastelGradientTests: XCTestCase {

    func testAllPresetsReturnAtLeastTwoColors() {
        let allCases: [PastelGradient] = [
            .warmFlame, .nightFade, .springWarmth, .juicyPeach, .youngPassion,
            .ladyLips, .sunnyMorning, .rainyAshville, .frozenDreams, .winterNeva,
            .dustyGrass, .temptingAzure, .heavyRain, .amyCrisp, .meanFruit,
            .deepBlue, .ripeMalinka, .cloudyKnoxville, .malibuBeach, .newLife,
            .trueSunset, .morpheusDen, .rareWind, .nearMoon, .wildApple,
            .saintPeterburg, .ariellesSmile, .plumPlate, .everlastingSky, .happyFisher
        ]
        XCTAssertEqual(allCases.count, 30, "Expected 30 presets")
        for gradient in allCases {
            let colors = gradient.colors()
            XCTAssertGreaterThanOrEqual(colors.count, 2, "\(gradient) must have at least 2 colors")
        }
    }
}
