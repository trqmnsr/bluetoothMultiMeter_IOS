//
//  MyButton.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 5/9/22.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .frame(width: 100, alignment: .center)
            .foregroundColor(configuration.isPressed ? .gray : .white)
            .padding()
            .background(isEnabled ? Color.accentColor : .gray)
            .cornerRadius(16)
            .padding(.horizontal)
    }
}

struct MyButton_Previews: PreviewProvider {
    static var previews: some View {
        Button("Share Image", action: {})
            .buttonStyle(MyButtonStyle())
        Button("Share", action: {})
            .buttonStyle(MyButtonStyle())
    }
}
