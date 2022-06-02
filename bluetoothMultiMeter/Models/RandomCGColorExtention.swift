//
//  RandomCGColorExtention.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/19/22.
//

import CoreGraphics

extension CGColor {
    
    static func getRandomColor() -> CGColor{
        
        let randomFloat = { () -> CGFloat in
            
            CGFloat.random(in: ClosedRange(uncheckedBounds: (lower: 0.0, upper: 1.0)) )
        }
        
        return CGColor.init(
            red: randomFloat(),
            green: randomFloat(),
            blue: randomFloat(),
            alpha: randomFloat()
            
        )
    }
}
