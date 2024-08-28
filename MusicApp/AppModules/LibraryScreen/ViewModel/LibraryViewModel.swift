//
//  LibraryViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 02/04/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

class LibraryViewModel {
    var videoList: [VideoListModel] = []
    var videoId: String = ""
    var playlistId: Int = -1

    func getSongsByPlaylist(playlistId: Int, isCompleted: @escaping isCompleted) {
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.video_playlist, extraString: playlistId.toString(), httpMethod: .get, requestObject: nil)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<[VideoListModel]>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                self.videoList = baseResponse.response ?? []
                isCompleted(true, "load Success.")
                isCompleted(true, "load Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

    func deleteSongsFromPlaylist(playlistId: Int, videoId: String, isCompleted: @escaping isCompleted) {
        let extraString = "/\(playlistId)/\(videoId)"
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.video_remove_playlist, extraString: extraString, httpMethod: .delete, requestObject: nil)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            isCompleted(true, "Removed Successfully.")
            /*let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<[VideoListModel]>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                self.videoList = baseResponse.response ?? []
                isCompleted(true, "load Success.")
                isCompleted(true, "load Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)*/
        }
    }
}
