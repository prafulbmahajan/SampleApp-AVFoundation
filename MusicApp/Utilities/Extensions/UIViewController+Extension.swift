//
//  UIViewController+Extension.swift
//  Music_App
//
//  Created by Praful Mahajan on 05/06/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlertWithOption(_ title: String, message: String, btn1Title: String = "Yes", btn2Title: String = "No", complete: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: btn1Title, style: .default, handler: { (action) in
            complete?()
        }))
        alert.addAction(UIAlertAction(title: btn2Title, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func showAlertOKAY(_ title: String, message: String, complete: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            complete?()
        }))
        self.present(alert, animated: true, completion: nil)
    }

    func showToast(withMessage message:String?, isCustomDuration: Bool = false, complete: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let when = DispatchTime.now() + (isCustomDuration ? 5 : 2)
        DispatchQueue.main.asyncAfter(deadline: when){
          alert.dismiss(animated: true, completion: nil)
            complete?()
        }
    }
}
