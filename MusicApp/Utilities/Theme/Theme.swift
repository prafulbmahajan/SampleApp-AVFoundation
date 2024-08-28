//
//  Theme.swift
//  DashboardTemplate
//
//  Created by Praful Mahajan on 06/07/20.
//  Copyright © 2020 Viriminfotech. All rights reserved.
//

import Foundation
import UIKit

final class Theme {
    private init() {}

    //UIColors
    static let themeColor: UIColor = UIColor.init(hexString: "#ff6d00")
    static let navTitleColor: UIColor = UIColor.init(hexString: "#ffffff")
    static let inputTextColor: UIColor = UIColor.init(hexString: "#767676")
    static let importantTextSnippets: UIColor = UIColor.init(hexString: "#333333")

    //UIFonts
    static let navTitleFont: UIFont = UIFont.systemFont(ofSize: 20)
    static let menuItemFont: UIFont = UIFont.systemFont(ofSize: 14)
    static let inputTextFont: UIFont = UIFont.systemFont(ofSize: 16)
    static let importantTextFont: UIFont = UIFont.systemFont(ofSize: 16)
}
