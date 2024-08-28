//
//  WelcomeViewController.swift
//  MusicApp
//
//  Created by Praful Mahajan on 17/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startButtonDidClicked(_ sender: Any) {
        if let vc = Generic.getViewControllerFromStoryBoard(type: TabViewController.self, storyBoard: .TABS) {
            AppDelegate.sharedInstance.window?.rootViewController = vc
        }
    }
}
