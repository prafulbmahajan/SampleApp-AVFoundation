//
//  AddToPlaylistRequestModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

struct AddToPlaylistRequestModel: Encodable {
    var video_id: String?
    var playlist_id: Int?

    init(video_id: String = "", playlist_id: Int = -1) {
        self.video_id = video_id
        self.playlist_id = playlist_id
    }
}
