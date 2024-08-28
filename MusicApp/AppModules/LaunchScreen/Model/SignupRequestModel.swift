//
//  SignupRequestModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 13/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

struct SignupRequestModel: Encodable {
    var email: String?
    var gender: Bool?
    var birthdate: String?
    var password: String?


    init(email: String = "", gender: Bool = true, birthdate: String = "", password: String = "") {
        self.email = email
        self.gender = gender
        self.birthdate = birthdate
        self.password = password
    }
}
