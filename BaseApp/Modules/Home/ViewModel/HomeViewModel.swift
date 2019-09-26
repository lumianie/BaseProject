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

struct HomeViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<APIManager>(endpointClosure: APIManagerEndpointClosure,
                                                    requestClosure: requestClosure,
                                                    manager: SecurityCertificationProvider.manager(), plugins: [NetworkLogger()])
    
    func todayHistory(param: [String: Any],
                      success: @escaping(_ response: TodayHistoryResponse) -> Void,
                      fail: @escaping(_ error: Error) -> Void) {
        provider.requestJson(.getTodayHistory(param: param), isCache: true)
            .mapObject(type: TodayHistoryResponse.self)
            .subscribe(onNext: { (response) in
                success(response)
            }, onError: { (error) in
                fail(error)
            }).disposed(by: disposeBag)
    }
}
