//
//  RSSIAntena.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/24/22.
//

import SwiftUI

struct RSSIAntena: View {
    
    @Binding var rssiValue: RssiSignal

    var body: some View {
        
        Image(systemName: "antenna.radiowaves.left.and.right")
            .symbolRenderingMode(.palette)
            .foregroundStyle(.blue, rssiValue.getColor())
    }
}

struct RSSIAntena_Previews: PreviewProvider {
    static var previews: some View {
        RSSIAntena(rssiValue: .constant(.amazing) )
    }
}
