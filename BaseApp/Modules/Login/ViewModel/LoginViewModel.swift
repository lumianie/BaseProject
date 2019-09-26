//
//  LoginViewModel.swift
//  BaseApp
//
//  Created by Lee on 2019/6/29.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import Moya
import RxSwift

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<APIManager>(endpointClosure: APIManagerEndpointClosure,
                                                    requestClosure: requestClosure,
                                                    manager: SecurityCertificationProvider.manager(), plugins: [NetworkLogger()])
    
    func userLogin(param: [String: Any],
                   success: @escaping(_ response: UserModel) -> Void,
                   fail: @escaping(_ error: Error) -> Void) {
        provider.requestJson(.login(param: param), isCache: false)
            .mapObject(type: UserModel.self)
            .subscribe(onNext: { (response) in
                success(response)
            }, onError: { (error) in
                fail(error)
            }).disposed(by: disposeBag)
    }
}
