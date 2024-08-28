//
//  SearchViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 26/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

class SearchViewModel {
    var youtubeModel: YoutubeModel?
    var items: [Item] = []
    var videoType: String = ""
    var videoList: [VideoListModel] = []
    var createPlaylistResponseModel: CreatePlaylistResponseModel?

    func getYoutubePlaylistFromChannel(complete: @escaping (Bool)-> Void) {
        let urlString = "https://www.googleapis.com/youtube/v3/playlists?part=snippet&channelId=\(Generic.kYoutubeChannelId)&key=\(Generic.kYoutubeAPIKey)"
        let configuration = APIConfiguration(baseUrl: urlString, httpMethod: .get)
        RequestManager.sharedInstance.withGet(apiConfiguration: configuration) { (response, error, code) in
            DispatchQueue.main.async {
                guard let response = response else { complete(false); return }
                let jsonData = Data(response.utf8)
                let decoder = JSONDecoder()
                self.youtubeModel = try? decoder.decode(YoutubeModel.self, from: jsonData)
                self.items = self.youtubeModel?.items ?? []
                complete(true)
            }
        }
    }

    func getYoutubePlaylistVideos(playListAPI: String, complete: @escaping (Bool)-> Void) {
        let urlString = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=\(playListAPI)&key=\(Generic.kYoutubeAPIKey)"
        let configuration = APIConfiguration(baseUrl: urlString, httpMethod: .get)
        RequestManager.sharedInstance.withGet(apiConfiguration: configuration) { (response, error, code) in
            DispatchQueue.main.async {
                guard let response = response else { complete(false); return }
                let jsonData = Data(response.utf8)
                let decoder = JSONDecoder()
                self.youtubeModel = try? decoder.decode(YoutubeModel.self, from: jsonData)
                self.items = self.youtubeModel?.items ?? []
                complete(true)
            }
        }
    }

    func getVideosByChoose(isCompleted: @escaping isCompleted) {
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.video, extraString: "/0/\(videoType)", httpMethod: .get, requestObject: nil)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<[VideoListModel]>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                self.videoList = baseResponse.response ?? []
                isCompleted(true, "load Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

    func createPlayList(playlistName: String, isCompleted: @escaping isCompleted) {
        let createPlaylistReqModel = CreatePlaylistRequestModel(name: playlistName, description: "", imageURL: "")
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.playlist, extraString: "/1", httpMethod: .post, requestObject: createPlaylistReqModel)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<CreatePlaylistResponseModel>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.id ?? 0) != 0 {
                self.createPlaylistResponseModel = baseResponse.response
                isCompleted(true, "Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

    func addSongsToPlaylist(videoId: String, playListId: Int, isCompleted: @escaping isCompleted) {
        let addToPlaylistRequestModel = AddToPlaylistRequestModel(video_id: videoId, playlist_id: playListId)
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.add_to_playlist, httpMethod: .post, requestObject: addToPlaylistRequestModel)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<AddToPlaylistResponseModel>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.id ?? 0) != 0 {
                isCompleted(true, "Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

}
