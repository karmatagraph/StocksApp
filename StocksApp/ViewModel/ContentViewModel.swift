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
    
    private let context = PersistenceController.shared.container.viewContext
    // cancellables
    private var cancellables = Set<AnyCancellable>()
//    private let symbols: [String] = [
//        "APPL",
//        "TSLA",
//        "IBM"
//    ]
    
    // to store the stock data
    @Published var stockData: [StockData] = []
    @Published var symbol: String = ""
    @Published var stockEntities: [StockEntity] = []
    
    init() {
        loadFromCoreData()
        loadAllSymbols()
    }
    
    func loadFromCoreData() {
        do {
            stockEntities = try context.fetch(StockEntity.fetchRequest())
        } catch let error {
            print(error.localizedDescription, "-------couldn't fetch from the core data")
        }
    }
    
    func addStock() {
        let newStock = StockEntity(context: context)
        newStock.symbol = symbol
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription)
        }
        stockEntities.append(newStock)
        getStockData(for: symbol)
        
        symbol = ""
    }
    
    func delete(at indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        stockData.remove(at: index)
        let stockToRemove = stockEntities.remove(at: index)
        context.delete(stockToRemove)
        do {
            try context.save()
        } catch let error {
            print(error.localizedDescription, "__--------delete failed")
        }
    }
    
    func loadAllSymbols() {
        stockData = []
        stockEntities.forEach { stockEntity in
            getStockData(for: stockEntity.symbol ?? "")
            print(stockEntity.symbol,"---------------stonks")
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
            } receiveValue: { [unowned self] stockData in
                DispatchQueue.main.async {
                    self.stockData.append(stockData)
                }
                print(stockData)
            }
            .store(in: &cancellables)

    }
//    @Published
    // create func to fetch the data for any stock symbol
    
}


