//
//  PastelView.swift
//  Pastel
//
//  Created by Cruz on 05/05/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

open class PastelView: UIView {

    private struct Animation {
        static let keyPath = "colors"
        static let key = "ColorChange"
    }

    //MARK: - Custom Direction

    /// The start point of the gradient, in unit coordinate space. Defaults to `.topRight`.
    open var startPoint: CGPoint = PastelPoint.topRight.point
    /// The end point of the gradient, in unit coordinate space. Defaults to `.bottomLeft`.
    open var endPoint: CGPoint = PastelPoint.bottomLeft.point

    /// A convenience setter for `startPoint` using a `PastelPoint` enum value.
    open var startPastelPoint = PastelPoint.topRight {
        didSet { startPoint = startPastelPoint.point }
    }

    /// A convenience setter for `endPoint` using a `PastelPoint` enum value.
    open var endPastelPoint = PastelPoint.bottomLeft {
        didSet { endPoint = endPastelPoint.point }
    }

    //MARK: - Custom Duration

    /// The duration of each individual gradient color-transition animation, in seconds. Defaults to `5.0`.
    open var animationDuration: TimeInterval = 5.0

    /// Optional shared animation state. When set, overrides individual animation properties.
    ///
    /// State is read at ``startAnimation()`` call time. Mutating state while an animation
    /// is running requires calling ``startAnimation()`` again to take effect.
    public var animationState: PastelAnimationState?

    fileprivate let gradient = CAGradientLayer()
    private var colors: [UIColor] = [
        UIColor(red: 156/255, green: 39/255,  blue: 176/255, alpha: 1.0),
        UIColor(red: 255/255, green: 64/255,  blue: 129/255, alpha: 1.0),
        UIColor(red: 123/255, green: 31/255,  blue: 162/255, alpha: 1.0),
        UIColor(red: 32/255,  green: 76/255,  blue: 255/255, alpha: 1.0),
        UIColor(red: 32/255,  green: 158/255, blue: 255/255, alpha: 1.0),
        UIColor(red: 90/255,  green: 120/255, blue: 127/255, alpha: 1.0),
        UIColor(red: 58/255,  green: 255/255, blue: 217/255, alpha: 1.0),
    ]

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    open override func awakeFromNib() {
        super.awakeFromNib()
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
    }

    /// Begins the animated gradient transition. Safe to call multiple times; each call
    /// stops any in-progress animation and restarts it without accumulating additional sublayers.
    public func startAnimation() {
        gradient.removeAllAnimations()
        setup()
        animateGradient()
    }

    fileprivate func setup() {
        gradient.removeFromSuperlayer()
        gradient.frame = bounds
        gradient.drawsAsynchronously = true

        if let state = animationState {
            let stateColors = state.colors
            gradient.colors = [stateColors[0].cgColor, stateColors[1].cgColor]
            gradient.startPoint = state.startPoint
            gradient.endPoint = state.endPoint
        } else {
            gradient.colors = [colors[0].cgColor, colors[1].cgColor]
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        layer.insertSublayer(gradient, at: 0)
    }

    /// Replaces the gradient color palette with the provided colors.
    /// - Parameter colors: An array of `UIColor` values. Must be non-empty.
    public func setColors(_ colors: [UIColor]) {
        guard colors.count > 0 else { return }
        self.colors = colors
    }

    /// Applies a preset `PastelGradient` color palette.
    /// - Parameter gradient: The preset gradient to use.
    public func setPastelGradient(_ gradient: PastelGradient) {
        setColors(gradient.colors())
    }

    /// Appends a color to the animation sequence.
    public func addColor(_ color: UIColor) {
        colors.append(color)
    }

    /// Deprecated. Use ``addColor(_:)`` instead.
    @available(*, deprecated, renamed: "addColor(_:)")
    public func addcolor(_ color: UIColor) {
        addColor(color)
    }

    private func animateGradient() {
        let activeColors: [UIColor]
        let duration: TimeInterval
        let timingCurve: PastelTimingCurve
        let repeatBehavior: RepeatBehavior
        let autoreverses: Bool

        if let state = animationState {
            activeColors   = state.colors
            duration       = state.duration
            timingCurve    = state.timingCurve
            repeatBehavior = state.repeatBehavior
            autoreverses   = state.autoreverses
        } else {
            activeColors   = colors
            duration       = animationDuration
            timingCurve    = .linear
            repeatBehavior = .forever
            autoreverses   = false
        }

        // Build keyframe values: each step transitions from colors[n] to colors[n+1],
        // with a wrap-around step back to colors[0] to close the loop seamlessly.
        var values: [[CGColor]] = []
        for i in 0 ..< activeColors.count {
            values.append([
                activeColors[i].cgColor,
                activeColors[(i + 1) % activeColors.count].cgColor,
            ])
        }
        values.append(values[0]) // wrap-around: keyTimes needs n+1 entries for n steps

        // keyTimes: n+1 evenly-spaced values from 0.0 to 1.0
        let keyTimes: [NSNumber] = (0 ... activeColors.count).map {
            NSNumber(value: Double($0) / Double(activeColors.count))
        }

        // timingFunctions: one per segment (values.count - 1 = activeColors.count)
        let timingFunctions = Array(
            repeating: CAMediaTimingFunction(name: timingCurve.caTimingFunction),
            count: activeColors.count
        )

        let animation = CAKeyframeAnimation(keyPath: Animation.keyPath)
        animation.values                = values
        animation.keyTimes              = keyTimes
        animation.timingFunctions       = timingFunctions
        animation.duration              = duration * Double(activeColors.count)
        animation.autoreverses          = autoreverses
        animation.fillMode              = .forwards
        animation.isRemovedOnCompletion = false

        switch repeatBehavior {
        case .forever:      animation.repeatCount = .infinity
        case .count(let n): animation.repeatCount = Float(n)
        }

        gradient.add(animation, forKey: Animation.key)
    }

    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }
}
