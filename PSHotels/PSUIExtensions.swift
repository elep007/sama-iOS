//
//  PSUIExtensions.swift
//  Restaurateur
//
//  Created by Panacea-Soft on 9/17/17.
//  Copyright © 2018 Panacea-Soft ( www.panacea-soft.com ). All rights reserved.
//

import Foundation

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableLabel: UILabel {
}


extension UIView {
    
    @IBInspectable
    var cornerRadiusForView: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}

@IBDesignable
extension UILabel {
    
    func setLineHeight(height: CGFloat, aligment : NSTextAlignment = .left) {
        
        ps.print("UILabel Custom function to set line height \(height)")
        if(height > 0) {
            
            
            let attributedString = NSMutableAttributedString(string: self.text!)
            
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyle = NSMutableParagraphStyle()
            
            // *** set LineSpacing property in points ***
            paragraphStyle.lineSpacing = height // Whatever line spacing you want in points
            
            paragraphStyle.alignment = aligment
            
            paragraphStyle.lineBreakMode = .byWordWrapping
            
            
            // *** Apply attribute to string ***
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
            
            
            
            // *** Set Attributed String to your label ***
            self.attributedText = attributedString;
            
            
        }
    }
}



