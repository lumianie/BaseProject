//
//  HomeViewModel.swift
//  BaseApp
//
//  Created by Lee on 2019/9/10.
//  Copyright © 2019 nielei. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import PromiseKit

struct HomeViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<APIManager>(endpointClosure: APIManagerEndpointClosure,
                                                    requestClosure: requestClosure,
                                                    manager: SecurityCertificationProvider.manager(), plugins: [NetworkLogger()])
    
    func getTodayHistory(param: [String: Any]) -> Promise<TodayHistoryResponse> {
        return Promise { seal in
            provider.requestJson(.getTodayHistory(param: param), isCache: true)
                .mapObject(type: TodayHistoryResponse.self)
                .subscribe(onNext: { (user) in
                    seal.fulfill(user)
                }, onError: { (error) in
                    seal.reject(error)
                }).disposed(by: disposeBag)
        }
    }
}
