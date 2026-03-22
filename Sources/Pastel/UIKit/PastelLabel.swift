//
//  PastelLabel.swift
//  Pastel
//
//  Created by Cruz on 21/05/2017.
//
//

import UIKit

public protocol PastelLabelable {
    var text: String? { get set }
    var font: UIFont? { get set }
    var textAlignment: NSTextAlignment { get set }
    var attributedText: NSAttributedString? { get set }
}

open class PastelLabel: PastelView, PastelLabelable {
    private let label = UILabel()
    
    //MARK: - PastelLabelable

    open var text: String? {
        didSet {
            label.text = text
        }
    }
    
    open var font: UIFont? {
        didSet {
            label.font = font
        }
    }
    
    open var attributedText: NSAttributedString? {
        didSet {
            label.attributedText = attributedText
        }
    }
    
    open var textAlignment: NSTextAlignment = .center {
        didSet {
            label.textAlignment = textAlignment
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        textAlignment = .center
        mask = label
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
