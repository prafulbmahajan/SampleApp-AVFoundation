//
//  CreatePlaylistRequestModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

struct CreatePlaylistRequestModel: Encodable {
    var name: String?
    var description: String?
    var imageURL: String?


    init(name: String = "", description: String = "", imageURL: String = "") {
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
}
