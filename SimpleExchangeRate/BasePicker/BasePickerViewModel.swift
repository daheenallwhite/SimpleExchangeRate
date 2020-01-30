//
//  HomeViewModel.swift
//  SimpleExchangeRate
//
//  Created by dana.allwhite on 2020/01/07.
//  Copyright © 2020 allwhite. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

struct BasePickerViewModel {
    let viewDidAppear = PublishSubject<Bool>()
    let baseCurrencyCode: BehaviorRelay<CurrencyCode> = BehaviorRelay(value: .USD)
    let exchangeRates: Driver<[Rate]>
    let lastUpdatedTime: Driver<String>
    let loading: Driver<Bool>
    
    private let exchangeRateAPI = ExchangeRateAPI.shared 
    
    init() {
        let viewAppearDefault = viewDidAppear
            .map { _ in
                return CurrencyCode.USD
            }
        
        let dataStream = Observable.merge(
            viewAppearDefault,
            baseCurrencyCode.asObservable()
        ).throttle(.milliseconds(400), scheduler: MainScheduler.instance)
        
        let result = dataStream
            .flatMapLatest(exchangeRateAPI.getRates(for:))
            .asObservable()
        
        let successData = result
            .map { data -> ResultData in
                guard case .success(let value) = data else { return ResultData.empty }
               return value
            }.share()
        
        self.exchangeRates = successData
            .map { data -> [Rate] in
                guard let rates = data.rates else { return [] }
                return rates.sorted { $0.code < $1.code }
        }.asDriver(onErrorJustReturn: [])
        
        self.lastUpdatedTime = successData
            .map({ (data) -> String in
                let date = Date(timeIntervalSince1970: Double(data.lastUpdatedTime ?? 0))
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                dateFormatter.timeZone = .current
                return dateFormatter.string(from: date)
            }).asDriver(onErrorJustReturn: "")
        
        self.loading = Observable.merge(
            dataStream.map { _ in true},
            successData.map { _ in false}
        ).startWith(true)
        .asDriver(onErrorJustReturn: false)
    }
}
