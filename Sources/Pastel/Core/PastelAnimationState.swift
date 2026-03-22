import UIKit

/// The shared animation state driving both UIKit and SwiftUI gradient layers.
///
/// Create an instance and pass it to ``PastelView``, ``PastelGradientView``,
/// or the ``pastelBackground(_:)`` modifier to coordinate animation configuration.
public final class PastelAnimationState: ObservableObject {

    /// Colors to cycle through. Must contain at least 2 elements.
    @Published public var colors: [UIColor]

    /// Duration of one color-to-color transition in seconds. Defaults to `5.0`.
    @Published public var duration: TimeInterval

    /// Easing curve applied to each color transition. Defaults to `.linear`.
    @Published public var timingCurve: PastelTimingCurve

    /// Controls how many times the animation repeats. Defaults to `.forever`.
    @Published public var repeatBehavior: RepeatBehavior

    /// When `true`, the animation reverses direction after each full cycle. Defaults to `false`.
    @Published public var autoreverses: Bool

    /// Gradient start in unit coordinates (0–1). Defaults to `(1, 0)` (top-trailing).
    @Published public var startPoint: CGPoint

    /// Gradient end in unit coordinates (0–1). Defaults to `(0, 1)` (bottom-leading).
    @Published public var endPoint: CGPoint

    /// Creates a new animation state.
    ///
    /// - Parameters:
    ///   - colors: Colors to cycle through. Must contain at least 2 elements.
    ///   - duration: Seconds per transition. Defaults to `5.0`.
    ///   - timingCurve: Easing applied to each transition. Defaults to `.linear`.
    ///   - repeatBehavior: How many times to repeat. Defaults to `.forever`.
    ///   - autoreverses: Whether to reverse direction on alternating cycles. Defaults to `false`.
    ///   - startPoint: Gradient start in unit space. Defaults to `(1, 0)` (top-trailing).
    ///   - endPoint: Gradient end in unit space. Defaults to `(0, 1)` (bottom-leading).
    /// - Precondition: `colors.count >= 2`.
    /// - Precondition: `repeatBehavior` must not be `.count(0)`.
    public init(
        colors: [UIColor],
        duration: TimeInterval = 5.0,
        timingCurve: PastelTimingCurve = .linear,
        repeatBehavior: RepeatBehavior = .forever,
        autoreverses: Bool = false,
        startPoint: CGPoint = CGPoint(x: 1, y: 0),
        endPoint: CGPoint = CGPoint(x: 0, y: 1)
    ) {
        precondition(colors.count >= 2, "PastelAnimationState requires at least 2 colors.")
        if case .count(let n) = repeatBehavior {
            precondition(n >= 1, "RepeatBehavior.count requires a value of at least 1.")
        }
        self.colors = colors
        self.duration = duration
        self.timingCurve = timingCurve
        self.repeatBehavior = repeatBehavior
        self.autoreverses = autoreverses
        self.startPoint = startPoint
        self.endPoint = endPoint
    }
}
