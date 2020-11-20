//
//  RoundedButton.swift
//  GS-Technology
//
//  Created by Mayank Rai on 02/05/20.
//  Copyright © 2020 Mayank Rai. All rights reserved.
//

import UIKit


@IBDesignable class RoundedButton: UIButton {
    
    @IBInspectable var radius: CGFloat =  0 { didSet{ updateUI() } }
    @IBInspectable dynamic open var border_color : UIColor = UIColor.clear {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable dynamic open var selected_border_color : UIColor = UIColor.clear {
        didSet {
            updateUI()
        }
    }
    
    @IBInspectable dynamic open var selected_backgroundColor : UIColor?
    @IBInspectable dynamic open var normal_backgroundColor: UIColor? {
        didSet {
            backgroundColor = normal_backgroundColor
        }
    }
    
    
    override open var isSelected: Bool {
        didSet {
            if isSelected {
                if selected_backgroundColor != nil {
                    backgroundColor = selected_backgroundColor
                    updateUI()
                }
            }
            else {
                if normal_backgroundColor != nil {
                    backgroundColor = normal_backgroundColor
                    updateUI()
                }
            }
        }
    }
    
    @IBInspectable var border_width : CGFloat = 0 {
        didSet {
            updateUI()
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
        layer.borderColor = isSelected ? selected_border_color.cgColor : border_color.cgColor
        layer.borderWidth = border_width
        layer.cornerRadius = radius == 0 ? layer.frame.size.height/2 : radius
        layer.masksToBounds = true
    }
    
    fileprivate func updateUI() {
        layer.borderColor = isSelected ? selected_border_color.cgColor : border_color.cgColor
        layer.borderWidth = border_width
        //print(radius)
        layer.cornerRadius = radius == 0 ? layer.frame.size.height/2 : radius
        layer.masksToBounds = true
        setNeedsDisplay()
    }
}
