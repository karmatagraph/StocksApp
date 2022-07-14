//
//  ContentView.swift
//  StocksApp
//
//  Created by karma on 7/14/22.
//

import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            List(){
                ForEach(0...10, id: \.self) { item in
                    HStack{
                        Text("symbol")
                        Spacer()
                        RoundedRectangle(cornerRadius: 8)
                            .frame(width: 100, height: 50)
                        VStack(alignment: .trailing){
                            Text("value")
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
