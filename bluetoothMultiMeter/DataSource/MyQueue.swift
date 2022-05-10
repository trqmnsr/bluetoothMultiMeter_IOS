//
//  MyQueue.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/6/22.
//

import Foundation
import Charts

class MyQueue {
    
    private var queue: [(Double,Double)]
    private var index: Int
    
    init() {
        queue = .init()
        index = -1
    }
    
    func isEmpty() -> Bool {
        return queue.isEmpty
    }
    
    
    
}
