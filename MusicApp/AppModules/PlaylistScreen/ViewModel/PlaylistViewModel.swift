//
//  PlaylistViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 27/02/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

class PlaylistViewModel {
    var playlist: [Playlist] = []
    func callGetPlaylistAPI(isCompleted: @escaping isCompleted) {
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.playlist, extraString: "/get-all/1", httpMethod: .get, requestObject: nil)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<[Playlist]>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                self.playlist = baseResponse.response ?? []
                LocalStore.setPlaylist(playlistName: self.playlist)
                isCompleted(true, "load Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

    func deletePlaylist(playlistId: Int, isCompleted: @escaping isCompleted) {
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.playlist, extraString: "/\(playlistId)", httpMethod: .delete, requestObject: nil)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            isCompleted(true, "Removed Successfully.")
            /*let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<[Playlist]>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                self.playlist = baseResponse.response ?? []
                LocalStore.setPlaylist(playlistName: self.playlist)
                isCompleted(true, "load Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)*/
        }
    }
}
