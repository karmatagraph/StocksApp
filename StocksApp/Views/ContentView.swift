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
                HStack {
                    TextField("Symbol" , text: $vm.symbol)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        vm.addStock()
                    } label: {
                        Text("Add")
                    }
                    .disabled(!vm.symbolValid)

                    
                }
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
                        }
                    }
                }
                .onDelete(perform: vm.delete(at:))
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
