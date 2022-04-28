//
//  TestView.swift
//  bluetoothMultiMeter
//
//  Created by Tareq Mansour on 4/23/22.
//

import SwiftUI

var fonts: [String]  {
    var l = [String]()
    for fontFamily in UIFont.familyNames {
        for fontName in UIFont.fontNames(forFamilyName: fontFamily) {
            l.append(fontName)
        }
    }
    return l
}

struct TestView: View {
    var body: some View {
        HStack() {
            Text("")
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
