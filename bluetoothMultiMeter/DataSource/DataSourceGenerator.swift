//
//  DataSourceGenerator.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/23/22.
//

import SwiftUI
import Charts


final class DataSourceGenerator: ObservableObject {
    
    private lazy var dataSet: LineChartDataSet = LineChartDataSet()
    @Published var name: String!
    
    var getDeviceName: String {
        name ?? "No Name"
    }
    
    var dataPoints: LineChartDataSet {
        if dataSet.isEmpty{
            return LineChartDataSet([ChartDataEntry(x: 0, y: 0)])
        }
        return dataSet
    }
    
    func addPoint(value: Double) -> Void {
        let time = Double(DispatchTime.now().uptimeNanoseconds)
        let newPoint = ChartDataEntry(x: time, y: value)
        dataSet.append(newPoint)
        dataSet.notifyDataSetChanged()
    }
    
    private static func now() -> Double{
        return Double(DispatchTime.now().uptimeNanoseconds) / 1000000000
        
    }
    
}
