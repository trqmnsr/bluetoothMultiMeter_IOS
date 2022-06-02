//
//  ModeToggle.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/25/22.
//

import SwiftUI

struct ModeToggle: View {
    
    @State var isToggled = true
    var label: String
    
    var body: some View {
        Toggle(label, isOn: $isToggled)
    }
}

struct ModeToggle_Previews: PreviewProvider {
    static var previews: some View {
        ModeToggle(label: "Voltmeter")
    }
}
