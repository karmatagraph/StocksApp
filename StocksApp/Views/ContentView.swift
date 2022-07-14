//
//  ContentView.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @ObservedObject private var vm = ContentViewModel()

    var body: some View {
        NavigationView {
            List(){
                ForEach(vm.stockData) { item in
                    HStack{
                        Text(item.metaData.symbol ?? "")
                        Spacer()
                        LineChart(values: item.closeValues)
                            .fill(
                                LinearGradient(
                                    colors: [.green.opacity(0.7), .green.opacity(0.2), .green.opacity(0)],
                                    startPoint: .top,
                                    endPoint: .bottom)
                            )
                            .frame(width: 100, height: 50)
                        VStack(alignment: .trailing){
                            Text(item.latestClose)
                            Text("change")
                        }
                    }
                }
            }
            .navigationTitle("Stonks")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    EditButton()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
