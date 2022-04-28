//
//  ContentView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import SwiftUI
import Charts

struct ChartLayout: View {
    
    @EnvironmentObject var dataSource: DataSourceGenerator
    
    var body: some View {
        
        VStack {
            Text("Device: \(dataSource.getDeviceName)")
            DetailsView()
            LineChartElement()
                .environmentObject(dataSource)
                .frame( alignment: .center)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChartLayout()
            .environmentObject(DataSourceGenerator())
            .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
