//
//  SignupModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 13/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

// MARK: - Response
struct SignupModel: Codable {
    let email, birthdate: String
    let gender: Bool
    let updatedAt, createdAt: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case email, birthdate, gender
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
