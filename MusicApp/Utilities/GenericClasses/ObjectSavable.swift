//
//  ObjectSavable.swift
//  MusicApp
//
//  Created by Praful Mahajan on 16/08/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

protocol ObjectSavable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
