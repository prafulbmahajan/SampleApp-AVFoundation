//
//  AccountViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 17/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

class AccountViewModel {
    func callLogoutAPI(isCompleted: @escaping isCompleted) {
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.logout, httpMethod: .get, requestObject: nil)
        RequestManager.sharedInstance.withGet(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<String>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                LocalStore.setAuthToken(authToken: baseResponse.response ?? "")
                isCompleted(true, baseResponse.response ?? "")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }
}
