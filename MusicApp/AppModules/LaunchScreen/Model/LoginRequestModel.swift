//
//  LoginRequestModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 17/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

struct LoginRequestModel: Encodable {
    var email: String?
    var password: String?

    init(email: String = "", password: String = "") {
        self.email = email
        self.password = password
    }
}

struct SigninRequestModel: Encodable {
    var email: String?
    var first_name: String?
    var last_name: String?
    var provider: String?
    var provider_user_id: String?

    init(email: String = "", first_name: String = "", last_name: String = "", provider: String = "", provider_user_id: String = "") {
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.provider = provider
        self.provider_user_id = provider_user_id
    }
}
