//
//  TabViewController.swift
//  Music_App
//
//  Created by Praful Mahajan on 01/06/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit
import Foundation

class TabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Generic.tabViewController = self
    }

    /*func setMimimizePlayer(audioName: String, ext: String, musicTitle: String, duration: String) {
        Generic.minimizeView.removeFromSuperview()
        Generic.minimizeView.initializeVideo(audioName: audioName, ext: ext, musicTitle: musicTitle, duration: duration)
        Generic.minimizeView.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 146, width: UIScreen.main.bounds.size.width, height: 64.0)
        
        Generic.tabViewController?.view.addSubview(Generic.minimizeView)
    }*/

}
