//
//  PastelImage.swift
//  Pastel
//

import SwiftUI

/// Image view with an animated gradient foreground fill applied through template rendering.
///
/// The image must have transparent areas to see the effect — the gradient shows
/// only where the image is opaque (alpha > 0).
///
/// For UIKit equivalents, see ``PastelImageView``.
@available(iOS 16.0, *)
public struct PastelImage: View {

    private let image: UIImage
    @ObservedObject private var state: PastelAnimationState

    @State private var currentIndex: Int = 0
    @State private var nextIndex: Int = 1
    @State private var isReversed: Bool = false
    @State private var cycleCount: Int = 0
    @State private var lastTransitionDate: Date = .now

    /// Creates a gradient image view from a preset.
    public init(_ image: UIImage, gradient: PastelGradient, duration: TimeInterval = 5.0) {
        self.image = image
        self.state = PastelAnimationState(colors: gradient.colors(), duration: duration)
    }

    /// Creates a gradient image view from custom colors.
    /// - Precondition: `colors.count >= 2`.
    public init(_ image: UIImage, colors: [UIColor], duration: TimeInterval = 5.0) {
        precondition(colors.count >= 2, "PastelImage requires at least 2 colors.")
        self.image = image
        self.state = PastelAnimationState(colors: colors, duration: duration)
    }

    /// Creates a gradient image view driven by a shared animation state.
    public init(_ image: UIImage, state: PastelAnimationState) {
        self.image = image
        self.state = state
    }

    public var body: some View {
        TimelineView(.animation) { timeline in
            let colors = state.colors
            Image(uiImage: image)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundStyle(
                    LinearGradient(
                        colors: colors.count >= 2
                            ? [Color(uiColor: colors[currentIndex]),
                               Color(uiColor: colors[nextIndex])]
                            : [Color.clear],
                        startPoint: UnitPoint(x: state.startPoint.x, y: state.startPoint.y),
                        endPoint: UnitPoint(x: state.endPoint.x, y: state.endPoint.y)
                    )
                )
                .onChange(of: timeline.date) { _ in advance(colors: colors) }
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
            if state.autoreverses {
                isReversed.toggle()
                nextIndex = isReversed
                    ? (currentIndex - 1 + colors.count) % colors.count
                    : (currentIndex + 1) % colors.count
            }
        }

        lastTransitionDate = .now
    }
}
