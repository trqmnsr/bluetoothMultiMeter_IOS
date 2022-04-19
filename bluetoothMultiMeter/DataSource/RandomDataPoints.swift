//
//  RandomDataPoints.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/14/22.
//

import Foundation
import Charts


class RandomDataPoints {
    
    private var value: Double
    private var time: Double
    private var chartData: [ChartDataEntry]
    private let timeInterval = 0.5
    private var activeTimer: Bool
    
    
    init() {
        self.value = 50.0
        self.time = 0.0
        self.activeTimer = false
        self.chartData = [ChartDataEntry(x: time, y: value)]
    }
    
    func getRandomDataPoint() -> [ChartDataEntry] {
        return self.chartData
    }
    
    private func addRandomDataPoint(timer: Timer) -> Void{
        self.value += Double.random(in: -0.5...0.5)
        self.time += timer.timeInterval
        let newpoint = ChartDataEntry(x: self.time, y: self.value)
        chartData.append(newpoint)
    }
}
