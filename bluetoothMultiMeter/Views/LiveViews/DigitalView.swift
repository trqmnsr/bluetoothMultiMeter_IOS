//
//  DigitalView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/28/22.
//

import SwiftUI



struct DigitalView: View {
    
    @EnvironmentObject var data: Peripheral
    
    var body: some View {
        Text("\(data.currentValue)")
    }
}

struct DigitalView_Previews: PreviewProvider {
    static var previews: some View {
        DigitalView()
    }
}
