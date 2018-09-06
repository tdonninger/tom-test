//
//  FormTextField.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class FormTextFieldView: CustomView {

    //MARK: Variables
    enum ValidationCase {
        case ok, ko
    }

    var titleText: String!
    private var titleLabel = UILabel()
    private var placeholderText: String!
    var textField = UITextField()
    private var validationView = UIView()
    
    //MARK: Init
    init(_ title: String, placeholder: String) {
        titleText = title
        placeholderText = placeholder
        super.init(frame: CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func commonInit() {
        super.commonInit()
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self).inset(Theme.MarginDefault)
        }
        titleLabel.setText(titleText, font: UIFont.systemFont(ofSize: 15), color: UIColor.smiileBlue)
        
        addSubview(validationView)
        validationView.snp.makeConstraints { (make) in
            make.height.width.equalTo(10)
            make.right.equalTo(self).inset(Theme.MarginDefault)
            make.centerY.equalTo(self).offset(14)
        }
        validationView.clipCornerRadius(10/2.0)
        
        addSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Theme.MarginLittle)
            make.left.equalTo(self).inset(Theme.MarginDefault)
            make.right.equalTo(validationView.snp.left).inset(Theme.MarginLittle)
        }
        textField.placeholder = placeholderText
        
        let borderView = UIView()
        addSubview(borderView)
        borderView.snp.makeConstraints { (make) in
            make.top.equalTo(textField.snp.bottom)
            make.right.left.bottom.equalTo(self).inset(Theme.MarginDefault)
            make.height.equalTo(1)
        }
        borderView.backgroundColor = UIColor.smiileBlue
    }
    
    //MARK: Functions
    func setValidation(_ validation: ValidationCase) {
        switch validation {
        case .ok:
            validationView.backgroundColor = UIColor.smiileGreen
        case .ko:
            validationView.backgroundColor = UIColor.smiileRed
        }
    }
}
