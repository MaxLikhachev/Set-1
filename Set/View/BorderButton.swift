//
//  BorderButton.swift
//  Set
//
//  Created by Татьяна Пятыхина on 08/12/2018.
//  Copyright © 2018 Татьяна Пятыхина. All rights reserved.
//

import UIKit

@IBDesignable class BorderButton: UIButton {
    
    private struct DefaultValues {
        static let cornerRadius: CGFloat = 5.0
        static let borderWidth: CGFloat = 3.0
        static let borderColor: UIColor   = #colorLiteral(red: 0, green: 0.831415832, blue: 0, alpha: 1)
    }
    
    @IBInspectable var cornerRadius: CGFloat = DefaultValues.cornerRadius {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = DefaultValues.borderWidth {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor:UIColor   = DefaultValues.borderColor {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure () {
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        clipsToBounds = true
    }
}
