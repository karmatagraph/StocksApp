//
//  StockService.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import Foundation
import Combine

struct StockService {
    
    static func getStockData(for symbol: String) -> AnyPublisher<StockData,Error> {
        let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol.uppercased())&interval=5min&apikey=\(ApiKey.apiKey)")!
        return URLSession.shared
            .dataTaskPublisher(for: url)
        // the trymap will transform the tuple of data and response into only data with status code of 200
            .tryMap { element -> Data in
                guard
                    let httpResponse = element.response as? HTTPURLResponse,
                    httpResponse.statusCode == 200
                else {
                    throw URLError(.badServerResponse)
                }
                return element.data
            }
            .decode(type: StockData.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
}
