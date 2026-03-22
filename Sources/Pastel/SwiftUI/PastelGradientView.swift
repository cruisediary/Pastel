import SwiftUI

/// Animated gradient view that transitions between a set of colors.
///
/// Use convenience initializers for simple cases.
/// For full control over easing, repeat behavior, and direction, pass a ``PastelAnimationState``.
@available(iOS 16.0, *)
public struct PastelGradientView: View {

    private let state: PastelAnimationState

    @State private var currentIndex: Int = 0
    @State private var nextIndex: Int = 1
    @State private var isReversed: Bool = false
    @State private var cycleCount: Int = 0
    @State private var lastTransitionDate: Date = .now

    /// Creates a gradient view from a preset.
    public init(gradient: PastelGradient, duration: TimeInterval = 5.0) {
        self.state = PastelAnimationState(colors: gradient.colors(), duration: duration)
    }

    /// Creates a gradient view from custom colors.
    /// - Precondition: `colors.count >= 2`.
    public init(colors: [UIColor], duration: TimeInterval = 5.0) {
        precondition(colors.count >= 2, "PastelGradientView requires at least 2 colors.")
        self.state = PastelAnimationState(colors: colors, duration: duration)
    }

    /// Creates a gradient view driven by a shared animation state.
    public init(state: PastelAnimationState) {
        self.state = state
    }

    public var body: some View {
        TimelineView(.animation) { timeline in
            let colors = state.colors
            if colors.count < 2 {
                Color.clear
            } else {
                LinearGradient(
                    colors: [
                        Color(uiColor: colors[currentIndex]),
                        Color(uiColor: colors[nextIndex])
                    ],
                    startPoint: UnitPoint(x: state.startPoint.x, y: state.startPoint.y),
                    endPoint: UnitPoint(x: state.endPoint.x, y: state.endPoint.y)
                )
                .onChange(of: timeline.date) { _ in
                    advance(colors: colors)
                }
            }
        }
    }

    private func advance(colors: [UIColor]) {
        // Stop if finite repeat count is exhausted
        if case .count(let n) = state.repeatBehavior, cycleCount >= Int(n) { return }
        guard Date.now.timeIntervalSince(lastTransitionDate) >= state.duration else { return }

        withAnimation(state.timingCurve.swiftUIAnimation(duration: state.duration)) {
            if isReversed {
                currentIndex = (currentIndex - 1 + colors.count) % colors.count
            } else {
                currentIndex = (currentIndex + 1) % colors.count
            }
            nextIndex = isReversed
                ? (currentIndex - 1 + colors.count) % colors.count
                : (currentIndex + 1) % colors.count
        }

        // Cycle completion: forward wraps to 0, reverse wraps to count-1
        let cycleComplete = isReversed
            ? currentIndex == colors.count - 1
            : currentIndex == 0
        if cycleComplete {
            cycleCount += 1
            if state.autoreverses { isReversed.toggle() }
        }

        lastTransitionDate = .now
    }
}
