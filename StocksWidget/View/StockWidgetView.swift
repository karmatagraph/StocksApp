//
//  StockWidgetView.swift
//  StocksWidgetExtension
//
//  Created by karma on 7/14/22.
//

import SwiftUI
import WidgetKit

struct StocksWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.configuration.symbol ?? "no value")
            Text(entry.stockData?.latestClose ?? "Default")
        }
    }
}
