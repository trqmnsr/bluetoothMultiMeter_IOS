//
//  DarkModeModifier.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 6/2/22.
//
import SwiftUI

public struct DarkModeViewModifier: ViewModifier {
    
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    public func body(content: Content) -> some View {
        content
            .environment(\.colorScheme, isDarkMode ? .dark : .light)
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}
