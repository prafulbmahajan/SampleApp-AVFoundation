//
//  LoginViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 14/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

class LoginViewModel {
    var email: String = ""
    var password: String = ""

    func isValidate() -> (isValid: Bool, message: String) {
        if email.isEmpty && password.isEmpty {
            return (false, ALL_FIELD)
        } else if email.isEmpty || email.count <= 0 {
            return (false, INVALID_EMAILID)
        } else if !(Generic.isValidEmail(email)) {
            return (false, INVALID_EMAILID)
        } else if password.isEmpty || password.count <= 0 {
            return (false, EMPTY_PASSWORD)
        }
        return (true, EMPTY)
    }

    func callSignupAPI(isCompleted: @escaping isCompleted) {
        let loginRequestModel = LoginRequestModel.init(email: self.email, password: self.password)
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.signin, httpMethod: .post, requestObject: loginRequestModel)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<String>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                LocalStore.setAuthToken(authToken: baseResponse.response ?? "")
                isCompleted(true, "Signin Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

    func callSigninAPI(email: String = "", first_name: String = "", last_name: String = "", provider: String = "", provider_user_id: String = "", isCompleted: @escaping isCompleted) {
        let signinRequestModel = SigninRequestModel.init(email: email, first_name: first_name, last_name: last_name, provider: provider, provider_user_id: provider_user_id)
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.signinprovider, httpMethod: .post, requestObject: signinRequestModel)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<String>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.count ?? 0) > 0 {
                LocalStore.setAuthToken(authToken: baseResponse.response ?? "")
                isCompleted(true, "Signin Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }
}
