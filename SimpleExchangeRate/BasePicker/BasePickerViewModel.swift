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
    let viewWillAppear = PublishSubject<Bool>()
    let baseCurrencySelected: BehaviorRelay<CurrencyCode> = BehaviorRelay(value: .USD)
    let selectedCurrencyRates: Driver<[Rate]>
    let lastUpdatedTime: Driver<String>
//    let errorMessage: Signal<String>
    
    private let exchangeRateAPI = ExchangeRateAPI.shared
    
    init() {
        // Todo: combine or merge viewWillAppear and baseCurrencySelected
        // 그 때, exchangeRateAPI getRates 호출
        
        let viewAppearDefault = viewWillAppear
            .map { _ in
                return CurrencyCode.USD
            }
        
        let dataStream = Observable.of(viewAppearDefault, baseCurrencySelected.asObservable()).merge()
        
        let result = dataStream
            .flatMapLatest(exchangeRateAPI.getRates(for:))
            .asObservable()
            .share()
        
        let successData = result
            .map { data -> ResultData in
                guard case .success(let value) = data else { return ResultData.empty }
               return value
            }
        
        self.selectedCurrencyRates = successData
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
    }
}
