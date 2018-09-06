//
//  LoginVC.swift
//  Smiile
//
//  Created by Thomas Donninger on 05/09/2018.
//  Copyright © 2018 Voodoo. All rights reserved.
//

import UIKit

class LoginVC: FormVC {

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        
        let emailTF = FormTextFieldView(tr("common.email"), placeholder: tr("common.email.placeholder"))
        emailTF.textField.keyboardType = .emailAddress
        addField(emailTF, validation: validateStringIsEmail)
        
        let passwordTF = FormTextFieldView(tr("common.password"), placeholder: tr("common.password.placeholder"))
        passwordTF.textField.isSecureTextEntry = true
        addField(passwordTF, returnKey: .done, validation: validateStringNotBlank)
    }
    
    override func submit() {
        super.submit()
        
        if validationError.isEmpty {
            //todo call UserService.login and do the transition in success completion block
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.didConnect(true)
        } else {
            let alert = UIAlertController(title: tr("common.error"), message: String(format: tr("form.error"), validationError.joined(separator: ", ")), preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: tr("common.ok"), style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
