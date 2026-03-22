//
//  PastelImageView.swift
//  Pastel
//

import UIKit

open class PastelImageView: PastelView {

    private let imageView = UIImageView()

    open var image: UIImage? {
        didSet { imageView.image = image }
    }

    // UIView.contentMode is a stored property on the superclass.
    // Override with didSet to forward the value to the inner imageView.
    open override var contentMode: UIView.ContentMode {
        didSet { imageView.contentMode = contentMode }
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
        contentMode = .scaleAspectFit   // triggers didSet → imageView.contentMode = .scaleAspectFit
        mask = imageView
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
}
