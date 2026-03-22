//
//  PastelPoint.swift
//  Pastel
//
//  Created by Cruz on 21/05/2017.
//
//

import UIKit

@objc
public enum PastelPoint: Int {
    /// The left-center edge of the gradient layer (x: 0.0, y: 0.5).
    case left
    /// The top-center edge of the gradient layer (x: 0.5, y: 0.0).
    case top
    /// The right-center edge of the gradient layer (x: 1.0, y: 0.5).
    case right
    /// The bottom-center edge of the gradient layer (x: 0.5, y: 1.0).
    case bottom
    /// The top-left corner of the gradient layer (x: 0.0, y: 0.0).
    case topLeft
    /// The top-right corner of the gradient layer (x: 1.0, y: 0.0).
    case topRight
    /// The bottom-left corner of the gradient layer (x: 0.0, y: 1.0).
    case bottomLeft
    /// The bottom-right corner of the gradient layer (x: 1.0, y: 1.0).
    case bottomRight

    /// The normalized `CGPoint` representation of this gradient anchor,
    /// suitable for use as `CAGradientLayer.startPoint` or `endPoint`.
    public var point: CGPoint {
        switch self {
        case .left: return CGPoint(x: 0.0, y: 0.5)
        case .top: return CGPoint(x: 0.5, y: 0.0)
        case .right: return CGPoint(x: 1.0, y: 0.5)
        case .bottom: return CGPoint(x: 0.5, y: 1.0)
        case .topLeft: return CGPoint(x: 0.0, y: 0.0)
        case .topRight: return CGPoint(x: 1.0, y: 0.0)
        case .bottomLeft: return CGPoint(x: 0.0, y: 1.0)
        case .bottomRight: return CGPoint(x: 1.0, y: 1.0)
        }
    }
}
