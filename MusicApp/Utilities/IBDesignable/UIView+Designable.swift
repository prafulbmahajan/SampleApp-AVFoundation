//
//  UIView+Designable.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {

    override var backgroundColor: UIColor? {
        didSet {
            if backgroundColor != nil && backgroundColor!.cgColor.alpha == 0 {
                backgroundColor = oldValue
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat = 0.0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var BorderColor: UIColor = UIColor.clear {
        didSet{
            self.layer.borderColor = BorderColor.cgColor

        }
    }
    @IBInspectable var cornerBorder: CGFloat = 0.0 {
        didSet{
            self.layer.cornerRadius = cornerBorder
            self.layer.masksToBounds = cornerBorder<0
        }
    }

    @IBInspectable var shadowOffHeight: Int = 0 {
        didSet{
            self.layer.shadowOffset = CGSize(width: 0, height: shadowOffHeight)
            self.layer.shadowOpacity = 0.5
        }
    }

    @IBInspectable var shadowColor: UIColor = .white {
        didSet{
            self.layer.shadowRadius = 3.0
            self.layer.shadowColor = shadowColor.cgColor
        }
    }

    func showBottomShadow (height : CGFloat, color : UIColor) {
        self.layer.shadowOffset = CGSize(width: 0.0, height: height)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = color.cgColor
    }
}
