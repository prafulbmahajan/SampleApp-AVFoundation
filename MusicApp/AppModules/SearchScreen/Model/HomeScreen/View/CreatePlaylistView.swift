//
//  CreatePlaylistView.swift
//  MusicApp
//
//  Created by Praful Mahajan on 17/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import UIKit

class CreatePlaylistView: UIView {
    static let ID = "CreatePlaylistView"
    var addOption: [AddOptions] = []
    var callBack : ((AddOptions, Int)->Void)?

    @IBOutlet weak var dismissAction: ActionButton!
    @IBOutlet weak var cancelAction: ActionButton!
    @IBOutlet weak var createAction: ActionButton!
    @IBOutlet weak var txtField: UITextField!

    class func instanceFromNib() -> CreatePlaylistView? {
        return UINib(nibName: CreatePlaylistView.ID, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CreatePlaylistView
    }
}
