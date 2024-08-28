//
//  SubscriptionViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 23/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var point1lbl: UILabel! {
        didSet {
            self.point1lbl.attributedText = Generic.changeTextColor(main_string: "• No more banner and pop-up ads.", string_to_color: "•", color: .red)
        }
    }

    @IBOutlet weak var point2lbl: UILabel! {
        didSet {
            self.point2lbl.attributedText = Generic.changeTextColor(main_string: "• Unlimited Access Premium video and audio.", string_to_color: "•", color: .red)
        }
    }

    @IBOutlet weak var point3lbl: UILabel! {
        didSet {
            self.point3lbl.attributedText = Generic.changeTextColor(main_string: "• Watch music mix Audio and video.", string_to_color: "•", color: .red)
        }
    }

    @IBOutlet weak var point4lbl: UILabel! {
        didSet {
            self.point4lbl.attributedText = Generic.changeMultipleTextColor(main_string: "• $35.88 for 1 year (Just $2.99/month).",
                                                                            string_to_color1: "•",
                                                                            string_to_color2: "$35.88",
                                                                            string_to_color3: "$2.99/month",
                                                                            color1: .red,
                                                                            color2: .white)
        }
    }

    @IBOutlet weak var point5lbl: UILabel! {
        didSet {
            self.point5lbl.attributedText = Generic.changeMultipleTextColor(main_string: "• By joining you accept our Terms of use and Privacy policy.",
                                                                            string_to_color1: "Terms of use",
                                                                            string_to_color2: "Privacy policy",
                                                                            string_to_color3: "",
                                                                            color1: .red,
                                                                            color2: .red)
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backButtonDidClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func monthSubscriptionButtonDidClicked(_ sender: Any) {
        self.showAlertWithOption("App Store", message: "Music app monthly Subscription with $ 2.99/m") {
            self.showToast(withMessage: "Payment is in progress...", isCustomDuration: true) {
                self.showAlertOKAY("Payment Success", message: "Please login again to enjoy the subscription.") {
                    if let vc = Generic.getViewControllerFromStoryBoard(type: LoginViewController.self, storyBoard: .MAIN) {
                        AppDelegate.sharedInstance.window?.rootViewController = vc
                    }
                }
            }
        }
    }

    @IBAction func yearSubscriptionButtonDidClicked(_ sender: Any) {
        self.showAlertWithOption("App Store", message: "Music app yearly Subscription with $ 35.88/yr") {
            self.showToast(withMessage: "Payment is in progress...", isCustomDuration: true) {
                self.showAlertOKAY("Payment Success", message: "Please login again to enjoy the subscription.") {
                    if let vc = Generic.getViewControllerFromStoryBoard(type: LoginViewController.self, storyBoard: .MAIN) {
                        AppDelegate.sharedInstance.window?.rootViewController = vc
                    }
                }
            }
        }
    }
}
