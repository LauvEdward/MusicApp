//
//  UIColor+Extension.swift
//  MusicApp
//
//  Created by Lauv Edward on 24/07/2021.
//

import UIKit
// MARK: - color in app
extension UIColor {
    class func RGB(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: 42/255, alpha: alpha)
    }
    // MARK: - use many views
    class var grayColorMain : UIColor {
        return UIColor.RGB(red: 41, green: 38, blue: 42, alpha: 1)
    }
    class var pinkColorMain: UIColor {
        return UIColor.RGB(red: 255, green: 57, blue: 170, alpha: 1)
    }
    class var blueColorMain: UIColor {
        return UIColor.init(red: 116, green: 81, blue: 255, alpha: 1)
    }
}

extension UIColor {
    
    convenience init(hexFromString: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexFromString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
