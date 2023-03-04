//
//  ColorInvert.swift
//  LebenInDeutschland
//
//  Created by Otim John Paul on 28.02.23.
//

import SwiftUI

struct ColorInvert: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        Group {
            if colorScheme == .dark {
                content.colorInvert()
            } else {
                content
            }
        }
    }
}
