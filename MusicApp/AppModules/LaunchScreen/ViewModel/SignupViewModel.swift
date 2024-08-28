//
//  SignupViewModel.swift
//  MusicApp
//
//  Created by Praful Mahajan on 13/01/21.
//  Copyright © 2021 prafulmahajan. All rights reserved.
//

import Foundation

class SignupViewModel {
    var email: String = ""
    var gender: Bool = true
    var birthdate: String = ""
    var password: String = ""

    func isValidate() -> (isValid: Bool, message: String) {
        if email.isEmpty && birthdate.isEmpty && password.isEmpty {
            return (false, ALL_FIELD)
        } else if email.isEmpty || email.count <= 0 {
            return (false, INVALID_EMAILID)
        } else if !(Generic.isValidEmail(email)) {
            return (false, INVALID_EMAILID)
        } else if password.isEmpty || password.count <= 0 {
            return (false, EMPTY_PASSWORD)
        } else if birthdate.isEmpty || birthdate.count <= 0 {
            return (false, EMPTY_DOB)
        }
        return (true, EMPTY)
    }

    func callSignupAPI(isCompleted: @escaping isCompleted) {
        let signupRequestModel = SignupRequestModel.init(email: self.email, gender: self.gender, birthdate: self.birthdate, password: self.password)
        let apiConfiguration = APIConfiguration(api_Module: API_MODULE.signup, httpMethod: .post, requestObject: signupRequestModel)
        RequestManager.sharedInstance.withPost(apiConfiguration: apiConfiguration) { (response, error, code) in
            guard let response = response else { isCompleted(false, NO_DATA_FOUND); return }
            print("****** Response *******", response)
            let jsonData = Data(response.utf8)
            let decoder = JSONDecoder()
            guard let baseResponse = try? decoder.decode(BaseResponse<SignupModel>.self, from: jsonData) else { isCompleted(false, NO_DATA_FOUND); return }
            if (baseResponse.response?.email.count ?? 0) > 0 {
                isCompleted(true, "Signup Success.")
                return
            }
            isCompleted(false, NO_DATA_FOUND)
        }
    }

}
