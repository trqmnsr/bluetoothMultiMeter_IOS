//
//  dataSource.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/17/22.
//

import Foundation
import Combine
import Charts



class DataSource: ObservableObject {
    
    @Published var dataPoints: [ChartDataEntry]
    
    init() {
        dataPoints = [ChartDataEntry(x:0.00, y: 0.0)]
    }
    
}

class RandomDataSource: DataSource {
    
    private static var currentValue = 50.0
    private static var currentTime = 0.0
    private var timer: Timer!
    
    
    init(initialValue initial: Double){
        super.init()
        dataPoints.append(ChartDataEntry(x: 0, y: initial))
        timerEvent(interval: 0.5)
    }
    
    func timerEvent(interval: Double) {
        self.timer = Timer(timeInterval: interval, repeats: true, block: {timer in
            RandomDataSource.currentValue += Double.random(in: -2...2)
            RandomDataSource.currentTime += timer.timeInterval
            let newPoint = ChartDataEntry(x: RandomDataSource.currentTime, y: RandomDataSource.currentValue )
            self.dataPoints.append(newPoint)
        })
        self.timer.fire()
    }
    
    
    func stopEvent() {
        self.timer.invalidate()
    }
    
}

class StaticDataSource: DataSource {

    override init() {
        super.init()
        for x_value in stride(from: 0.0, to: 30.0, by: 0.2) {
            self.dataPoints.append(ChartDataEntry(x:x_value, y: Double.random(in: (-5...5))))
        }
    }
}
    
