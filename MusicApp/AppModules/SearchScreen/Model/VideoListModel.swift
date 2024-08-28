//
//  VideoListModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - Response
struct VideoListModel: Codable {
    let id: String?
    let name: String?
    let video_description: String?
    let file: String?

    enum CodingKeys: String, CodingKey {
        case id, name, file
        case video_description = "description"
    }
}
