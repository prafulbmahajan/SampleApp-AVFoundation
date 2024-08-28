//
//  TypeAlias.swift
//  MusicApp
//
//  Created by Praful Mahajan on 29/05/20.
//  Copyright © 2020 prafulmahajan. All rights reserved.
//

import Foundation

typealias isCompleted = (Bool, String) -> Void
typealias isAlertCompleted = (Bool) -> Void
typealias JSONCompletionHandler = (String?, Error?, Int?) -> Void
typealias completionHandler = JSONCompletionHandler
