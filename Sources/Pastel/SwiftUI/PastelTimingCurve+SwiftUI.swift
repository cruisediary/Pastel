import SwiftUI

extension PastelTimingCurve {
    /// A SwiftUI Animation with this curve and the given duration.
    func swiftUIAnimation(duration: TimeInterval) -> Animation {
        switch self {
        case .linear:    return .linear(duration: duration)
        case .easeIn:    return .easeIn(duration: duration)
        case .easeOut:   return .easeOut(duration: duration)
        case .easeInOut: return .easeInOut(duration: duration)
        }
    }
}
