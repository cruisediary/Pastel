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
        didSet {
            startPoint = startPastelPoint.point
        }
    }

    /// A convenience setter for `endPoint` using a `PastelPoint` enum value.
    open var endPastelPoint = PastelPoint.bottomLeft {
        didSet {
            endPoint = endPastelPoint.point
        }
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
    private var currentGradient: Int = 0
    private var colors: [UIColor] = [UIColor(red: 156/255, green: 39/255, blue: 176/255, alpha: 1.0),
                             UIColor(red: 255/255, green: 64/255, blue: 129/255, alpha: 1.0),
                             UIColor(red: 123/255, green: 31/255, blue: 162/255, alpha: 1.0),
                             UIColor(red: 32/255, green: 76/255, blue: 255/255, alpha: 1.0),
                             UIColor(red: 32/255, green: 158/255, blue: 255/255, alpha: 1.0),
                             UIColor(red: 90/255, green: 120/255, blue: 127/255, alpha: 1.0),
                             UIColor(red: 58/255, green: 255/255, blue: 217/255, alpha: 1.0)]

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
    /// stops any in-progress animation and restarts it without accumulating additional
    /// sublayers. The gradient color sequence continues from its current position — the
    /// internal index counter is not reset to zero.
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
            gradient.colors = [
                stateColors[currentGradient % stateColors.count].cgColor,
                stateColors[(currentGradient + 1) % stateColors.count].cgColor
            ]
            gradient.startPoint = state.startPoint
            gradient.endPoint = state.endPoint
        } else {
            gradient.colors = currentGradientSet()
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        layer.insertSublayer(gradient, at: 0)
    }

    fileprivate func currentGradientSet() -> [CGColor] {
        guard colors.count > 0 else { return [] }
        return [colors[currentGradient % colors.count].cgColor,
                colors[(currentGradient + 1) % colors.count].cgColor]
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
        currentGradient += 1
        let animation = CABasicAnimation(keyPath: Animation.keyPath)

        if let state = animationState {
            animation.duration = state.duration
            animation.timingFunction = CAMediaTimingFunction(name: state.timingCurve.caTimingFunction)
            switch state.repeatBehavior {
            case .forever:      animation.repeatCount = .infinity
            case .count(let n): animation.repeatCount = Float(n)
            }
            animation.autoreverses = state.autoreverses
            // Use state.colors for the animated transition, cycling via currentGradient index
            let stateColors = state.colors
            animation.toValue = [
                stateColors[currentGradient % stateColors.count].cgColor,
                stateColors[(currentGradient + 1) % stateColors.count].cgColor
            ]
        } else {
            animation.duration = animationDuration
            animation.toValue = currentGradientSet()
        }

        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.delegate = self
        gradient.add(animation, forKey: Animation.key)
    }

    open override func removeFromSuperview() {
        super.removeFromSuperview()
        gradient.removeAllAnimations()
        gradient.removeFromSuperlayer()
    }
}

extension PastelView: CAAnimationDelegate {
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = currentGradientSet()
            animateGradient()
        }
    }
}
