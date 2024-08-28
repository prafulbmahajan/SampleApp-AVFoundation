//
//  CreatePlaylistResponseModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - Response
struct CreatePlaylistResponseModel: Codable {
    let id: Int?
    let name: String?
    let playlist_description: String?
    let image_url: String?
    let is_subscribed: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name, image_url
        case is_subscribed
        case playlist_description = "description"
    }
}
