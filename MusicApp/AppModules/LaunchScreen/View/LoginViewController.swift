//
//  LoginViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    var loginViewModel: LoginViewModel?
    
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
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        if let token = AccessToken.current,
            !token.isExpired {
        }
    }

    @IBAction func loginButtonDidClicked(_ sender: Any) {
        self.emailTextField.resignFirstResponder()
        self.passwordTextField.resignFirstResponder()

        self.loginViewModel = LoginViewModel()
        self.loginViewModel?.email = self.emailTextField.text ?? ""
        self.loginViewModel?.password = self.passwordTextField.text ?? ""
        let isValid = self.loginViewModel?.isValidate()
        if (isValid?.isValid ?? true) {
            self.activityIndicator.startAnimating()
            self.loginViewModel?.callSignupAPI(isCompleted: { (response, message) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showToast(withMessage: message) {
                        if response {
                            LocalStore.setSelectedSegment(segment: 1)
                            self.navigateToDashboard()
                        }
                    }
                }
            })
        } else {
            self.showToast(withMessage: isValid?.message ?? "Please enter valid input.")
        }
    }

    @IBAction func skipButtonDidClicked(_ sender: Any) {
        self.navigateToDashboard()
    }

    @IBAction func facebookButtonDidClicked(_ sender: Any) {//action of the custom button in the storyboard
        let fbLoginManager : LoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["email"], from: self) { (result, error) -> Void in
        if (error == nil){
            let fbloginresult : LoginManagerLoginResult = result!
          // if user cancel the login
          if (result?.isCancelled)!{
                  return
          }
          if(fbloginresult.grantedPermissions.contains("email"))
          {
            self.getFBUserData()
          }
        }
      }
    }

    func getFBUserData(){
        if((AccessToken.current) != nil){
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
          if (error == nil){
            self.activityIndicator.startAnimating()
            self.loginViewModel?.callSigninAPI(email: "email@email.com", first_name: "first_name", last_name: "last_name", provider: "Facebook", provider_user_id: Generic.randomString(), isCompleted: { (response, message) in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.showToast(withMessage: message) {
                        if response {
                            LocalStore.setSelectedSegment(segment: 1)
                            self.navigateToDashboard()
                        }
                    }
                }
            })
          }
        })
      }
    }

    @IBAction func googleButtonDidClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    }

    @IBAction func singupButtonDidClicked(_ sender: Any) {
        if let vc = Generic.getViewControllerFromStoryBoard(type: SignupViewController.self, storyBoard: .MAIN) {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func navigateToDashboard() {
        if let vc = Generic.getViewControllerFromStoryBoard(type: WelcomeViewController.self, storyBoard: .MAIN) {
            AppDelegate.sharedInstance.window?.rootViewController = vc
        }
    }

}

extension LoginViewController: UITextFieldDelegate {
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

extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
        // Perform any operations on signed in user here.
        let userId = user.userID ?? ""                 // For client-side use only!
        let name = user.profile.name ?? ""
        let familyName = user.profile.familyName ?? ""
        let email = user.profile.email ?? ""
        self.activityIndicator.startAnimating()
        self.loginViewModel?.callSigninAPI(email: email, first_name: name, last_name: familyName, provider: "Google", provider_user_id: userId, isCompleted: { (response, message) in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showToast(withMessage: message) {
                    if response {
                        LocalStore.setSelectedSegment(segment: 1)
                        self.navigateToDashboard()
                    }
                }
            }
        })
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
}
