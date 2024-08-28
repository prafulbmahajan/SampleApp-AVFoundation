//
//  PlaylistCreateModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 27/02/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - LoginResponseModel
struct PlaylistCreateModel: Codable {
    let response: [Playlist]?

    enum CodingKeys: String, CodingKey {
        case response
    }
}

// MARK: - Response
struct Playlist: Codable {
    let id: Int?
    let name: String?
    let is_subscribed: Int?
    let playlist_description: String?
    let image_url: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image_url
        case is_subscribed
        case playlist_description = "description"
    }
}
