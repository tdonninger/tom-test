//
//  CharteGraphique.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

//MARK: App Theme
struct Theme
{
    static let MarginLittle : CGFloat = 8.0
    static let MarginBig : CGFloat = 20.0
    static let MarginExtraBig : CGFloat = 20.0
    static let MarginDefault : CGFloat = 15.0
    static let FontSizeDefault : CGFloat = 19.0
    static let FieldHeight : CGFloat = 50.0
    static let ButtonHeight : CGFloat = 50.0
    
    static func setupTheme() {
        UINavigationBar.appearance().barTintColor = UIColor.smiileBlue
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey(rawValue: NSAttributedStringKey.foregroundColor.rawValue): UIColor.white]

        UISearchBar.appearance().tintColor = UIColor.white
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
    }
}

//MARK: Extension UIColor
extension UIColor {
    
    class var smiileExtraLightGrey: UIColor {
        return UIColor(red: 253.0 / 255.0, green: 253.0 / 255.0, blue: 253.0 / 255.0, alpha: 1.0)
    }
    
    class var smiileBlue: UIColor {
        return UIColor(red: 28.0 / 255.0, green: 173.0 / 255.0, blue: 216.0 / 255.0, alpha: 1.0)
    }
    
    class var smiileGreen: UIColor {
        return UIColor(red: 38.0 / 255.0, green: 160.0 / 255.0, blue: 90.0 / 255.0, alpha: 1.0)
    }

    class var smiileRed: UIColor {
        return UIColor(red: 178.0 / 255.0, green: 40.0 / 255.0, blue: 84.0 / 255.0, alpha: 1.0)
    }
    
    convenience init(r:Int, g:Int, b:Int) {
        self.init(red:CGFloat(r)/255, green:CGFloat(g)/255, blue:CGFloat(b)/255, alpha:1)
    }
    
    convenience init(hexString: String) {
        var rgb: UInt32 = 0
        
        let s = Scanner(string: hexString)
        s.scanLocation = 1 // ignore leading `#`
        s.scanHexInt32(&rgb)
        
        let red   = (rgb >> 16) & 0xff
        let green = (rgb >>  8) & 0xff
        let blue  = (rgb) & 0xff
        
        self.init(r:Int(red), g:Int(green), b:Int(blue))
    }
}
