//
//  AddToPlaylistResponseModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - Response
struct AddToPlaylistResponseModel: Codable {
    let id: Int?
    let video_id: String?
    let playlist_id: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case video_id
        case playlist_id
    }
}
