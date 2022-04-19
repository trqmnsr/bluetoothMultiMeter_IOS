//
//  TestDataSource.swift
//  btMultimeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import Foundation
import Charts

struct StaticDataPoint {
    var voltage: Double
    var time: Double
    
    static func voltageEntries(dataPoints:[StaticDataPoint]) -> [ChartDataEntry] {
        return dataPoints.map{ChartDataEntry(x: $0.time, y: $0.voltage)}
    }
    
    
    
    static var FakeDataPoints:[StaticDataPoint] {
        [
            StaticDataPoint(voltage: 50.0, time: 0.00),
            StaticDataPoint(voltage: 51.6, time: 0.10),
            StaticDataPoint(voltage: 55.3, time: 0.20),
            StaticDataPoint(voltage: 58.4, time: 0.30),
            StaticDataPoint(voltage: 56.0, time: 0.40),
            StaticDataPoint(voltage: 57.5, time: 0.50),
            StaticDataPoint(voltage: 56.4, time: 0.60),
            StaticDataPoint(voltage: 52.3, time: 0.70),
            StaticDataPoint(voltage: 49.0, time: 0.80),
            StaticDataPoint(voltage: 48.0, time: 0.90),
            StaticDataPoint(voltage: 42.6, time: 1.00),
            StaticDataPoint(voltage: 45.6, time: 1.10),
            StaticDataPoint(voltage: 47.0, time: 1.20),
            StaticDataPoint(voltage: 43.0, time: 1.30),
            StaticDataPoint(voltage: 50.0, time: 1.40),
            StaticDataPoint(voltage: 50.0, time: 1.50),
            StaticDataPoint(voltage: 50.0, time: 1.60),
            StaticDataPoint(voltage: 50.0, time: 1.70),
            StaticDataPoint(voltage: 50.0, time: 1.80),
            StaticDataPoint(voltage: 50.0, time: 1.90),
        ]
    }
}


