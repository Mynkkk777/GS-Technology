//
//  GradientButton.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class GradientButton: UIButton {
    let gradientLayer = CAGradientLayer()
     @IBInspectable var radius: CGFloat =  0 { didSet{ setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)} }
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeButton()
    }
    
    func initializeButton() {
        //layer.borderColor = isSelected ? selected_border_color.cgColor : border_color.cgColor
        //layer.borderWidth = border_width
        layer.cornerRadius = radius == 0 ? layer.frame.size.height/2 : radius
        layer.masksToBounds = true
    
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = radius == 0 ? layer.frame.size.height/2 : radius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}


class GradientView: UIView {
    
    let gradientLayer = CAGradientLayer()
    
    
    @IBInspectable
       var topGradientColor: UIColor? {
           didSet {
               setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
           }
       }
       
       @IBInspectable
       var bottomGradientColor: UIColor? {
           didSet {
               setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
           }
       }
    
    @IBInspectable var radius: CGFloat =  0 { didSet{ setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)} }
       
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = radius == 0 ? layer.cornerRadius : radius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}

class GradientImageTint: UIImageView {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }

    
    
    
    
}

