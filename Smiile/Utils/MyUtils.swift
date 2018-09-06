//
//  MyUtils.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

//MARK: Variables
let AppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

let OSVersion = UIDevice.current.systemVersion

var currentUsableLocale : String {
    return Bundle.main.preferredLocalizations.first ?? "en"
}

//MARK: Helper
func tr(_ key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

var ScreenWidth : CGFloat {
    get {
        return UIScreen.main.bounds.size.width
    }
}

//MARK: Demo Only
func readJsonFile(_ jsonFile: String) -> Any? {
    do {
        if let file = Bundle.main.url(forResource: jsonFile, withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if json is [String: Any] {
                // json is a dictionary
                //print(object)
                return json
            } else if json is [Any] {
                // json is an array
                //print(object)
                return json
            } else {
                print("JSON is invalid")
                return nil
            }
        } else {
            print("no file")
            return nil
        }
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

//MARK: Class CustomView
class CustomView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
    }
}

//MARK: Class CustomButton
class CustomButton: UIButton {
    
    typealias ActionBlock = ((_ button: CustomButton) -> ())
    private var actionBlock: ActionBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
    }
    
    func addTarget(_ actionBlock: @escaping ActionBlock){
        self.actionBlock = actionBlock
        self.addTarget(self, action: #selector(executeActionBlock), for: .touchUpInside)
    }
    
    func removeActionBlock() {
        actionBlock = nil
    }
    
    @objc func executeActionBlock() {
        if let actionBlock = actionBlock {
            actionBlock(self)
        }
    }
}

//MARK: Class CustomUITableViewCell
class CustomUITableViewCell: UITableViewCell {
    
    override init (style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
    }
    
    class func cellIdentifier () -> String {
        return NSStringFromClass(self)
    }
}

//MARK: Class CustomUICollectionViewCell
class CustomUICollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    internal func commonInit() {
    }
    
    class func cellIdentifier () -> String {
        return NSStringFromClass(self)
    }
}

//MARK: Extension UIView
extension UIView {
    func clipCornerRadius(_ cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
    }
}

//MARK: Extension UIButton
extension UIButton {
    func setTitle(_ text: String?) {
        self.setTitle(text, for: UIControlState())
    }
    
    func setTitleColor(_ color: UIColor?) {
        self.setTitleColor(color, for: UIControlState())
    }
    
    func setTitle(_ title: String?, font: UIFont?, color: UIColor?, backgroundColor: UIColor? = nil) {
        self.setTitle(title, for: UIControlState())
        self.setFont(font, color: color, backgroundColor: backgroundColor)
    }
    
    func setFont(_ font: UIFont?, color: UIColor?, backgroundColor: UIColor? = nil) {
        self.titleLabel?.font = font
        self.setTitleColor(color, for: UIControlState())
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}

//MARK: Extension UILabel
extension UILabel {
    func setText(_ text: String?, font: UIFont?, color: UIColor?, textAlignment: NSTextAlignment? = .left) {
        self.text = text
        self.setFont(font, color: color, textAlignment: textAlignment)
    }

    func setFont(_ font: UIFont?, color: UIColor?, textAlignment: NSTextAlignment? = .left, backgroundColor: UIColor? = nil) {
        self.font = font
        self.textColor = color
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}

//MARK: Extension UITextfield
extension UITextField {
    func setText(_ text: String?, font: UIFont?, color: UIColor?) {
        self.text = text
        self.setFont(font, color: color)
    }
    
    func setFont(_ font: UIFont?, color: UIColor?) {
        self.font = font
        self.textColor = color
    }
    
    func setFont(_ font: UIFont?, textAlignment: NSTextAlignment?) {
        self.font = font
        
        if let textAlignment = textAlignment {
            self.textAlignment = textAlignment
        }
    }
    
    func setFont(_ font: UIFont?, color: UIColor?, backgroundColor: UIColor?) {
        self.setFont(font, color: color)
        
        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }
}

//MARK: Extension String
extension String {
    static func isBlank (_ text: String?) -> Bool {
        if text == nil || text!.count == 0{
            return true
        }
        return false
    }
    
    func concatString(text: String, char: String = " ") -> String {
        var fullString = self
        if text.count > 0 {
            if self.count > 0 {
                fullString = fullString.appendingFormat("%@%@", char, text)
            } else {
                fullString = fullString.appending(text)
            }
        }
        return fullString
    }
}
