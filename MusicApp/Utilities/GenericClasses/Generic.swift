//
//  Generic.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation
import UIKit
//import SideMenuSwift

final class Generic {

    static let kClientId = "a582e5de-8ece-43cc-a363-2824d84f6914"
    static let kAuthority = "https://login.microsoftonline.com/common"
    static let kGraphEndpoint = "https://graph.microsoft.com/"
    static let kRedirectUri = "msauth.com.virim.coronis://auth"
    static let kScopes: [String] = ["user.read"]
    static let kGIDSignInClientId = "654178855520-2bouqcl79247ile138ahgaigfud297rm.apps.googleusercontent.com"
    static let kYoutubeAPIKey = "AIzaSyBasqwmx7Zo04YcFO5mrNWNLQqVAdstQlM"
    static let kYoutubeMainPlaylistAPI = "PL_4r3OJy4dPDrj3mkKE-9R3IRTY_xHbt1"
    static let kYoutubeGenreshiphopPlaylistId = "PLyORnIW1xT6waC0PNjAMj33FdK2ngL_ik"
    static let kYoutubeGenresPopPlaylistId = "PLyORnIW1xT6yzGiFVWCDL6q3qCVD08yS_"
    static let kYoutubeChannelId = "UCgR4pXCr9fGiUvZfsnlZ2Hg"

    static var tabViewController: TabViewController?

    static func getViewControllerFromStoryBoard<T: UIViewController>(type: T.Type, storyBoard: Storyboard) -> T? {
        var fullName: String = NSStringFromClass(T.self)
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        if let range = fullName.range(of:".", options:.backwards, range:nil, locale: nil){
            fullName = String(fullName[range.upperBound...])
        }
        return storyboard.instantiateViewController(withIdentifier:fullName) as? T
    }

    static func getNavigationControllerFromStoryBoard(container: NavigationContainer, storyBoard: Storyboard) -> UIViewController {
        let storyboard = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: container.rawValue)
    }

    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    static func addToSubView(view: UIView) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        view.frame = UIScreen.main.bounds
        appDelegate.window?.addSubview(view)
    }

    static func removeFromSuperView(view: UIView?) {
        if view != nil {
            view?.removeFromSuperview()
        }
    }

    static func changeTextColor(main_string: String, string_to_color: String, color: UIColor)-> NSMutableAttributedString {

        let range = (main_string as NSString).range(of: string_to_color)

        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attribute
    }

    static func changeMultipleTextColor(main_string: String, string_to_color1: String, string_to_color2: String, string_to_color3: String = "", color1: UIColor, color2: UIColor)-> NSMutableAttributedString {

        let range1 = (main_string as NSString).range(of: string_to_color1)
        let range2 = (main_string as NSString).range(of: string_to_color2)
        let range3 = (main_string as NSString).range(of: string_to_color3)

        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color1, range: range1)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color2, range: range2)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color2, range: range3)
        return attribute
    }

    static func randomString(length: Int = 6) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in (letters.randomElement() ?? "a") })
    }

    static func returnVideoId(videoListModel: VideoListModel) -> String {
        let file = videoListModel.file
        let component = file?.components(separatedBy: "/")
        return component?.last ?? ""
    }
}
