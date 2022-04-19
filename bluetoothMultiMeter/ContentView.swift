//
//  ContentView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import SwiftUI
import Charts

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            Text("Here is the Graph")
            TransactionLineChartView()
                .environmentObject(StaticDataSource())
                .frame(height: 400, alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(StaticDataSource())
    }
}
