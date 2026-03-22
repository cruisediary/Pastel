import SwiftUI

/// Text view with an animated gradient foreground fill.
///
/// For UIKit equivalents, see ``PastelLabel``.
@available(iOS 16.0, *)
public struct PastelText: View {

    private let text: String
    private let font: Font
    private let state: PastelAnimationState

    @State private var currentIndex: Int = 0
    @State private var nextIndex: Int = 1
    @State private var isReversed: Bool = false
    @State private var cycleCount: Int = 0
    @State private var lastTransitionDate: Date = .now

    /// Creates a gradient text view from a preset.
    public init(_ text: String, font: Font = .body, gradient: PastelGradient, duration: TimeInterval = 5.0) {
        self.text = text
        self.font = font
        self.state = PastelAnimationState(colors: gradient.colors(), duration: duration)
    }

    /// Creates a gradient text view from custom colors.
    /// - Precondition: `colors.count >= 2`.
    public init(_ text: String, font: Font = .body, colors: [UIColor], duration: TimeInterval = 5.0) {
        precondition(colors.count >= 2, "PastelText requires at least 2 colors.")
        self.text = text
        self.font = font
        self.state = PastelAnimationState(colors: colors, duration: duration)
    }

    /// Creates a gradient text view driven by a shared animation state.
    public init(_ text: String, font: Font = .body, state: PastelAnimationState) {
        self.text = text
        self.font = font
        self.state = state
    }

    public var body: some View {
        TimelineView(.animation) { timeline in
            let colors = state.colors
            Text(text)
                .font(font)
                .foregroundStyle(
                    LinearGradient(
                        colors: colors.count >= 2
                            ? [Color(uiColor: colors[currentIndex]), Color(uiColor: colors[nextIndex])]
                            : [Color.clear],
                        startPoint: UnitPoint(x: state.startPoint.x, y: state.startPoint.y),
                        endPoint: UnitPoint(x: state.endPoint.x, y: state.endPoint.y)
                    )
                )
                .onChange(of: timeline.date) { _ in
                    advance(colors: colors)
                }
        }
    }

    private func advance(colors: [UIColor]) {
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

        let cycleComplete = isReversed ? currentIndex == colors.count - 1 : currentIndex == 0
        if cycleComplete {
            cycleCount += 1
            if state.autoreverses { isReversed.toggle() }
        }

        lastTransitionDate = .now
    }
}
