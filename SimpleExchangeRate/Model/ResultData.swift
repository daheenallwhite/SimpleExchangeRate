//
//  ResultData.swift
//  SimpleExchangeRate
//
//  Created by Daheen Lee on 2020/01/02.
//  Copyright © 2020 allwhite. All rights reserved.
//

import Foundation

struct ResultData: Decodable {
    static let empty = ResultData(
    base: "USD",
    date : "2020.01.06",
    lastUpdatedTime: 100,
    rates: ["KRW": 1200.0])
    
    let base: String?
    let date: String?
    let lastUpdatedTime: Int?
    let rates: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case base, date, rates
        case lastUpdatedTime = "time_last_updated"
    }
    
    init(base: String,
         date: String,
         lastUpdatedTime: Int,
         rates: [String: Double]) {
        self.base = base
        self.date = date
        self.lastUpdatedTime = lastUpdatedTime
        self.rates = rates
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.base = try? values.decode(String.self, forKey: .base)
        self.date = try? values.decode(String.self, forKey: .date)
        self.lastUpdatedTime = try? values.decode(Int.self, forKey: .lastUpdatedTime)
        self.rates = try? values.decode([String: Double].self, forKey: .rates)
    }
    
    var ratesString: [String] {
        guard let rates = self.rates else { return [] }
        return rates.map({ (key, value) -> String in
            "\(key) \(value)"
        })
    }
}
