//
//  RegisterVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class RegisterVC: FormVC {
        
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = tr("register.title")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Functions
    override func loadView() {
        super.loadView()
        
        createFields()
    }
    
    func createFields() {
        let nameTF = FormTextFieldView(tr("register.name"), placeholder: tr("register.name.placeholder"))
        addField(nameTF, validation: validateStringNotBlank)
        
        let firstnameTF = FormTextFieldView(tr("register.firstname"), placeholder: tr("register.firstname.placeholder"))
        addField(firstnameTF, validation: validateStringNotBlank)

        let emailTF = FormTextFieldView(tr("common.email"), placeholder: tr("common.email.placeholder"))
        emailTF.textField.keyboardType = .emailAddress
        addField(emailTF, validation: validateStringIsEmail)

        let passwordTF = FormTextFieldView(tr("common.password"), placeholder: tr("common.password.placeholder"))
        passwordTF.textField.isSecureTextEntry = true
        addField(passwordTF, validation: validateStringNotBlank)

        let addressTF = FormTextFieldView(tr("register.address"), placeholder: tr("register.address.placeholder"))
        addField(addressTF, returnKey: .done, validation: validateStringNotBlank)
    }
    
    override func submit() {
        super.submit()
        
        if validationError.isEmpty {
            // Waring : doesn't keep the info and init a static user (see fakeUser.json)
            //todo call UserService.register and do the transition in success completion block
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.didConnect(true)
        } else {
            let alert = UIAlertController(title: tr("common.error"), message: String(format: tr("form.error"), validationError.joined(separator: ", ")), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: tr("common.ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
