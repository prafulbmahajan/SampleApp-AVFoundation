//
//  LocalStore.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

struct LocalStore {
    fileprivate static let userDefaults = UserDefaults.standard
    fileprivate static let kSetFavorite = "kSetFavorite"
    fileprivate static let kSetPlaylistName = "kSetPlaylistName"
    fileprivate static let kSegmentSelected = "kSegmentSelected"
    fileprivate static let kUserId = "kUserId"
    fileprivate static let kAuthToken = "kAuthToken"

    //MARK:- Favorite Tracks
    static func setFavorites(favoriteTrack: [AddOptions]) {
        try? userDefaults.setObject(favoriteTrack, forKey: kSetFavorite)
        userDefaults.synchronize()
    }

    static func getFavorites() ->[AddOptions] {
        guard let list = try? userDefaults.getObject(forKey: kSetFavorite, castTo: [AddOptions].self) else { return [] }
        return list
    }

    //MARK:- Playlist Name
    static func setPlaylist(playlistName: [Playlist]) {
        try? userDefaults.setObject(playlistName, forKey: kSetPlaylistName)
        userDefaults.synchronize()
    }

    static func getPlaylist() ->[Playlist] {
        guard let list = try? userDefaults.getObject(forKey: kSetPlaylistName, castTo: [Playlist].self) else { return [] }
        return list
    }

    //MARK:- Playlist Songs
    static func setPlaylistSongs(tracks: [AddOptions], key: String) {
        try? userDefaults.setObject(tracks, forKey: key)
        userDefaults.synchronize()
    }

    static func getPlaylistSongs(key: String) ->[AddOptions] {
        guard let list = try? userDefaults.getObject(forKey: key, castTo: [AddOptions].self) else { return [] }
        return list
    }

    //MARK:- Segment Select
    static func setSelectedSegment(segment: Int) {
        userDefaults.set(segment, forKey: kSegmentSelected)
        userDefaults.synchronize()
    }

    static func getSelectedSegment() -> Int {
        if let value = userDefaults.value(forKey: kSegmentSelected) as? Int {
            return value
        }
        return 0
    }

    //MARK:- Auth Token
    static func setAuthToken(authToken: String) {
        userDefaults.set(authToken, forKey: kAuthToken)
        userDefaults.synchronize()
    }

    static func getAuthToken() -> String {
        if let selection = userDefaults.object(forKey: kAuthToken) as? String {
            return selection
        }
        return ""
    }
}

