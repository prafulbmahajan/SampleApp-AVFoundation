//
//  YoutubeModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 26/07/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - YoutubeModel
struct YoutubeModel: Codable {
    let kind, etag: String?
    let items: [Item]?
    let pageInfo: PageInfo?
}

// MARK: - YoutubeSearchModel
struct YoutubeSearchModel: Codable {
    let kind, etag: String?
    let items: [Items]?
    let pageInfo: PageInfo?
}

// MARK: - Items
struct Items: Codable {
    let kind, etag: String?
    let id: ResourceID?
    let snippet: Snippet?
}

// MARK: - Item
struct Item: Codable {
    let kind, etag, id: String?
    let snippet: Snippet?
}

// MARK: - Snippet
struct Snippet: Codable {
    let publishedAt: String?
    let channelID, title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let channelTitle, playlistID: String?
    let position: Int?
    let resourceID: ResourceID?

    enum CodingKeys: String, CodingKey {
        case publishedAt
        case channelID = "channelId"
        case title
        case snippetDescription = "description"
        case thumbnails, channelTitle
        case playlistID = "playlistId"
        case position
        case resourceID = "resourceId"
    }
}

// MARK: - ResourceID
struct ResourceID: Codable {
    let kind, videoID: String?

    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "videoId"
    }
}

// MARK: - Thumbnails
struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: Default?
    let maxres: Default?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard, maxres
    }
}

// MARK: - Default
struct Default: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - PageInfo
struct PageInfo: Codable {
    let totalResults, resultsPerPage: Int?
}
