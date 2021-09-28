//
//  UIColor+Extension.swift
//  MusicApp
//
//  Created by mobven semih on 7.09.2021.
//

import UIKit


extension UIColor {
    class var primaryColor: UIColor {
        UIColor(hex:"1d1d1d")
    }
    class var secondaryColor: UIColor {
        UIColor(red: 21/255, green: 21/255, blue: 21/255, alpha: 1)
    }
    
    class var softBlack: UIColor {
        UIColor(red: 28/255, green: 28/255, blue: 28/255, alpha: 1)
    }
    
    class var verySoftBlack: UIColor {
        UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1)
    }
    
    convenience init(hex: String) {
        var hexString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        guard hexString.count == 6 else {
            self.init(red:  153 / 255.0,
                      green: 153 / 255.0,
                      blue: 153 / 255.0,
                      alpha: 1)
            return
        }
        var rgbValue: UInt32 = 0
        Scanner(string: hexString).scanHexInt32(&rgbValue)
        self.init(red:CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: CGFloat(1.0))
    }
}
