import UIKit

/// Easing curve applied to each gradient color transition.
public enum PastelTimingCurve {
    /// Constant speed throughout the transition.
    case linear
    /// Starts slowly then speeds up.
    case easeIn
    /// Starts fast then slows down.
    case easeOut
    /// Starts slowly, speeds up, then slows down.
    case easeInOut

    /// The corresponding CAMediaTimingFunctionName for use by the UIKit layer.
    var caTimingFunction: CAMediaTimingFunctionName {
        switch self {
        case .linear:    return .linear
        case .easeIn:    return .easeIn
        case .easeOut:   return .easeOut
        case .easeInOut: return .easeInEaseOut
        }
    }
}

/// Defines how many times a gradient animation cycle repeats.
public enum RepeatBehavior {
    /// Repeats indefinitely.
    case forever
    /// Repeats a fixed number of times.
    ///
    /// - Precondition: The associated value must be ≥ 1.
    ///   Passing `0` triggers a precondition failure at `PastelAnimationState` initializer call site.
    case count(UInt)
}
