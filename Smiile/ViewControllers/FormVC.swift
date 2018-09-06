//
//  FormVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class FormVC: UIViewController {

    //MARK: Variables
    typealias Validation = (String?) -> Bool

    var titleLabel = UILabel()
    private var scrollView = UIScrollView()
    var stackView = UIStackView()
    var activeTextView : UIView?
    private var textFields = [UITextField]()
    // tuple
    private var validationsRules = [(Int, FormTextFieldView, Validation)]()
    var validationError = [String]()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = UIColor.smiileExtraLightGrey
        
        let closeButton = ActionButton(.close)
        view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.top.right.equalTo(view.safeAreaLayoutGuide).inset(Theme.MarginDefault)
        }
        closeButton.addTarget { (button) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let imageView = UIImageView(image: UIImage(named: "logo"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(Theme.MarginBig)
            make.width.height.equalTo(75)
            make.centerX.equalTo(view)
        }
        imageView.clipCornerRadius(75/2.0)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(Theme.MarginExtraBig)
            make.left.right.equalTo(view.safeAreaLayoutGuide).inset(Theme.MarginDefault)
            make.centerX.equalTo(view)
        }
        titleLabel.setFont(UIFont.systemFont(ofSize: 15), color: UIColor.smiileBlue)
        titleLabel.numberOfLines = 0
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(Theme.MarginDefault)
            make.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.delegate = self
        
        let submitButton = ActionButton(.blue)
        scrollView.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
        submitButton.setTitle(tr("common.submit"))
        submitButton.addTarget { (button) in
            self.submit()
        }
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(scrollView)
            make.bottom.equalTo(submitButton.snp.top).offset(-Theme.MarginDefault)
            make.width.equalTo(view)
        }
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
    }
    
    func addField(_ myView: FormTextFieldView, returnKey: UIReturnKeyType = .next, validation: @escaping Validation) {
        textFields.append(myView.textField)
        validationsRules.append((validationsRules.count, myView, validation))
        stackView.addArrangedSubview(myView)
        myView.snp.makeConstraints { (make) in
            make.left.right.equalTo(view)//.inset(Theme.MarginDefault)
        }
        myView.textField.delegate = self
        myView.textField.returnKeyType = returnKey
    }
    
    func findAndValidateField(_ textField: UITextField) {
        if let index = textFields.index(of: textField) {
            presubmit(validationsRules[index])
            if index+1 < textFields.count {
                textFields[index+1].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
            }
        }
    }
    
    func presubmit(_ fieldToValidate: (Int, FormTextFieldView, Validation)? = nil) {
        
        var formTextFieldViewToValidate = [(_: Int, formTextField: FormTextFieldView, validation: Validation)]()
        if let fieldToValidate = fieldToValidate {
            formTextFieldViewToValidate = [fieldToValidate]
        } else {
            formTextFieldViewToValidate = validationsRules
        }
        validationError.removeAll()
        for validationRule in formTextFieldViewToValidate {
            if !validationRule.validation(validationRule.formTextField.textField.text) {
                validationRule.formTextField.setValidation(.ko)
                validationError.append(validationRule.formTextField.titleText)
            } else {
                validationRule.formTextField.setValidation(.ok)
            }
        }
    }
    
    func submit() {
        activeTextView?.resignFirstResponder()
        presubmit()
    }
    
    //MARK: Default validation
    func validateNotNil (_ value: String?) -> Bool {
        return value != nil
    }
    
    func validateStringNotBlank (_ value: String?) -> Bool {
        if let value = value, !String.isBlank(value) {
            return true
        }
        return false
    }
    
    func validateStringIsEmail (_ value: String?) -> Bool {
        if let value = value, !String.isBlank(value) {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: value)
        }
        return false
    }
    
    //MARK: Keyboard Handling
    func registerForKeyboardNotifications () {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidAppear(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidAppear (_ notification: Notification) {
        if let info = (notification as NSNotification).userInfo {
            
            if let keyboardHeight = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size.height {
                scrollView.contentInset = UIEdgeInsetsMake(0, 0, keyboardHeight + 40, 0)
                
                if let activeTextView = activeTextView {
                    let rect = activeTextView.superview!.convert(activeTextView.frame, to: self.scrollView)
                    self.scrollView.scrollRectToVisible(rect, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillDisappear () {
        scrollView.contentInset = UIEdgeInsets.zero
    }
}

//MARK: UITextFieldDelegate
extension FormVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextView = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        activeTextView = nil
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        findAndValidateField(textField)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        findAndValidateField(textField)
        return true
    }
}

//MARK: UIScrollViewDelegate
extension FormVC: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        activeTextView?.resignFirstResponder()
    }
}
