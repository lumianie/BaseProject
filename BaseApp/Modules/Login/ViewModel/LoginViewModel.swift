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
import PromiseKit

class LoginViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<APIManager>(endpointClosure: APIManagerEndpointClosure,
                                                    requestClosure: requestClosure,
                                                    manager: SecurityCertificationProvider.manager(), plugins: [NetworkLogger()])
    
    func userLogin(param: [String: Any]) -> Promise<User> {
        return Promise { seal in
            provider.requestJson(.login(param: param))
                .mapObject(type: User.self)
                .subscribe(onNext: { (user) in
                    seal.fulfill(user)
                }, onError: { (error) in
                    seal.reject(error)
                }).disposed(by: disposeBag)
        }
    }
}
