//
//  ValidatorViewController.swift
//  animated-validator-swift
//
//  Created by Flatiron School on 6/27/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Darwin

class ValidatorViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailConfirmationTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.submitButton.accessibilityLabel = Constants.SUBMITBUTTON
        self.emailTextField.accessibilityLabel = Constants.EMAILTEXTFIELD
        self.emailConfirmationTextField.accessibilityLabel = Constants.EMAILCONFIRMTEXTFIELD
        self.phoneTextField.accessibilityLabel = Constants.PHONETEXTFIELD
        self.passwordTextField.accessibilityLabel = Constants.PASSWORDTEXTFIELD
        self.passwordConfirmTextField.accessibilityLabel = Constants.PASSWORDCONFIRMTEXTFIELD
        
        self.submitButton.isEnabled = false
    }
    
    @IBAction func doneEditingEmail(_ sender: UITextField) {
        if let email = self.emailTextField.text {
            if !email.contains("@") || !email.contains(".") {
                self.redPulse(sender)
            } else if emailConfirmationTextField.text != "" {
                if email != emailConfirmationTextField.text {
                    self.redPulse(sender)
                    self.redPulse(self.emailConfirmationTextField)
                }
            }
        }
        enableSubmitButton()
    }
    
    @IBAction func doneEditingEmailConfirm(_ sender: UITextField) {
        if emailConfirmationTextField.text != emailTextField.text && emailTextField.text != "" {
            self.redPulse(sender)
            self.redPulse(self.emailTextField)
        }
        enableSubmitButton()
    }
    
    @IBAction func doneEditingPhone(_ sender: UITextField) {
        if (self.phoneTextField.text?.characters.count)! >= 7 {
            self.redPulse(sender)
        }
        enableSubmitButton()
    }
    
    @IBAction func doneEditingPassword(_ sender: UITextField) {
        if (self.passwordTextField.text?.characters.count)! < 6 {
            self.redPulse(sender)
        }
        enableSubmitButton()
    }
    
    
    @IBAction func doneEditingConfirmPassword(_ sender: UITextField) {
        if self.passwordConfirmTextField.text != self.passwordTextField.text {
            self.redPulse(sender)
        }
        enableSubmitButton()
    }
    
    func redPulse(_ sender: UITextField) {
        UIView.animate(withDuration: 0.5, animations: { _ in
            sender.backgroundColor = UIColor.red
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {_ in
                sender.backgroundColor = self.view.backgroundColor
            })
        })
        UIView.animate(withDuration: 0.5, animations: { _ in
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 1.0)
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, animations: {_ in
                sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
    
    func enableSubmitButton() {
        if self.passwordConfirmTextField.text! == self.passwordTextField.text! && (self.phoneTextField.text?.characters.count)! >= 7 && emailConfirmationTextField.text! == emailTextField.text! && (self.passwordConfirmTextField.text?.characters.count)! > 1{
            self.submitButton.isEnabled = true
        }
    }
    
}
