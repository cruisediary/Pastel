import SwiftUI

@available(iOS 16.0, *)
struct PastelGradientModifier: ViewModifier {
    let state: PastelAnimationState

    func body(content: Content) -> some View {
        content.background(PastelGradientView(state: state))
    }
}

@available(iOS 16.0, *)
extension View {
    /// Applies an animated gradient background using a preset.
    public func pastelBackground(_ gradient: PastelGradient, duration: TimeInterval = 5.0) -> some View {
        modifier(PastelGradientModifier(state: PastelAnimationState(colors: gradient.colors(), duration: duration)))
    }

    /// Applies an animated gradient background using custom colors.
    /// - Precondition: `colors.count >= 2`.
    public func pastelBackground(colors: [UIColor], duration: TimeInterval = 5.0) -> some View {
        modifier(PastelGradientModifier(state: PastelAnimationState(colors: colors, duration: duration)))
    }

    /// Applies an animated gradient background driven by a shared state object.
    public func pastelBackground(state: PastelAnimationState) -> some View {
        modifier(PastelGradientModifier(state: state))
    }
}
