//
//  SignupViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    var toolBar = UIToolbar()
    var datePicker  = UIDatePicker()
    var signupViewModel: SignupViewModel?

    @IBOutlet weak var dobButton: UIButton!
    @IBOutlet weak var genderButton: UIButton!

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            self.emailTextField.delegate = self
            self.emailTextField.tag = 0
        }
    }

    @IBOutlet weak var emailTick: UIImageView! {
        didSet {
            self.emailTick.isHidden = true
        }
    }

    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            self.passwordTextField.delegate = self
            self.passwordTextField.tag = 1
        }
    }

    @IBOutlet weak var passwordTick: UIImageView! {
        didSet {
            self.passwordTick.isHidden = true
        }
    }

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.hidesWhenStopped = true
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backButtonDidClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func signupButtonDidClicked(_ sender: Any) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()

        self.signupViewModel = SignupViewModel()
        self.signupViewModel?.email = self.emailTextField.text ?? ""
        self.signupViewModel?.password = self.passwordTextField.text ?? ""
        self.signupViewModel?.gender = (self.genderButton.titleLabel?.text ?? "").uppercased() == "MALE"
        self.signupViewModel?.birthdate = self.dobButton.titleLabel?.text ?? ""

        let isValid = self.signupViewModel?.isValidate()
        if (isValid?.isValid ?? true) {
            self.activityIndicator.startAnimating()
            self.signupViewModel?.callSignupAPI(isCompleted: { (response, message) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showToast(withMessage: message) {
                        if response {
                            let vc = Generic.getNavigationControllerFromStoryBoard(container: .LoginContainer, storyBoard: .MAIN)
                            AppDelegate.sharedInstance.window?.rootViewController = vc
                        }
                    }
                }
            })
        } else {
            self.showToast(withMessage: isValid?.message ?? "Please enter valid input.")
        }
    }

    @IBAction func dobButtonDidClicked(_ sender: Any) {
        self.showDatePicker()
    }

    @IBAction func genderButtonDidClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Gender", message: "Please select gender", preferredStyle: UIAlertController.Style.actionSheet)
         alert.addAction(UIAlertAction(title: "Male",style: .default, handler: { action in
            self.genderButton.setTitle("Male", for: .normal)
           }))
         alert.addAction(UIAlertAction(title: "Female", style: .default, handler: { action in
            self.genderButton.setTitle("Female", for: .normal)
           }))
        // Add cancel UIAlertAction
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension SignupViewController {
    func showDatePicker() {
        datePicker = UIDatePicker.init()
        datePicker.backgroundColor = UIColor.white

        datePicker.autoresizingMask = .flexibleWidth
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()

        datePicker.addTarget(self, action: #selector(self.dateChanged(_:)), for: .valueChanged)
        datePicker.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(datePicker)

        toolBar = UIToolbar(frame: CGRect(x: 0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil), UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.onDoneButtonClick))]
        toolBar.sizeToFit()
        self.view.addSubview(toolBar)
    }

    @objc func dateChanged(_ sender: UIDatePicker?) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if (sender?.date) != nil {
            self.dobButton.setTitle(dateFormatter.string(from: datePicker.date), for: .normal)
        }
    }

    @objc func onDoneButtonClick() {
        toolBar.removeFromSuperview()
        datePicker.removeFromSuperview()
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        if textField.tag == 0 {
            self.emailTick.isHidden = newString.count == 0
        } else if textField.tag == 1 {
            self.passwordTick.isHidden = newString.count == 0
        }
        return true
    }
}

