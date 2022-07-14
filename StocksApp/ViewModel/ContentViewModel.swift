//
//  ContentViewModel.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import Foundation
import Combine
import SwiftUI

final class ContentViewModel: ObservableObject {
    // cancellables
    private var cancellables = Set<AnyCancellable>()
    private let symbols: [String] = [
        "APPL",
        "TSLA",
        "IBM"
    ]
    
    // to store the stock data
    @Published var stockData: [StockData] = []
    
    init() {
        getStockData(for: "IBM")
    }
    
    func loadAllSymbols() {
        stockData = []
        symbols.forEach { symbol in
            getStockData(for: symbol)
        }
    }
    func getStockData(for symbol: String) {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol.uppercased())&interval=5min&apikey=\(ApiKey.apiKey)") else { return }
        URLSession.shared
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
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(let error):
                    print(error)
                    return
                }
            } receiveValue: { [weak self] stockData in
                DispatchQueue.main.async {
                    self?.stockData.append(stockData)
                }
                print(stockData)
            }
            .store(in: &cancellables)

    }
//    @Published
    // create func to fetch the data for any stock symbol
    
}


