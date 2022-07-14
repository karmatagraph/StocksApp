//
//  StockData.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import Foundation
//
//// MARK: - Welcome
//struct StockData: Codable {
//    let metaData: MetaData?
//    let timeSeries5Min: [String: StockDataEntry]?
//}
//
//// MARK: - MetaData
//struct MetaData: Codable {
//    let the1Information, the2Symbol, the3LastRefreshed, the4Interval: String?
//    let the5OutputSize, the6TimeZone: String?
//}
//
//// MARK: - TimeSeries5Min
//struct StockDataEntry: Codable {
//    let the1Open, the2High, the3Low, the4Close: String?
//    let the5Volume: String?
//}

// MARK: - StockData
struct StockData: Codable, Identifiable {
    let metaData: MetaData?
    let timeSeries5Min: [String: TimeSeries5Min]?
    
    private enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries5Min = "Time Series (5min)"
    }
    
    let id = UUID()
    var latestClose: String {
        timeSeries5Min?.first?.value.close ?? "NaN"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    let information, symbol, lastRefreshed, interval: String?
    let outputSize, timeZone: String?
    
    private enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}

// MARK: - TimeSeries5Min
struct TimeSeries5Min: Codable {
    let open, high, low, close: String?
    let volume: String?
    
    private enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

