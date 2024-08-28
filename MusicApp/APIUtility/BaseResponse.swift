//
//  BaseResponse.swift
//  MusicApp
//
//  Created by Praful Mahajan on 14/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let response: T?

    enum CodingKeys: String, CodingKey {
        case response
    }
}
