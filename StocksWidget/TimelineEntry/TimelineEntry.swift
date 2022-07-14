//
//  TimelineEntry.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import Foundation
import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
    let stockData: StockData?
}
