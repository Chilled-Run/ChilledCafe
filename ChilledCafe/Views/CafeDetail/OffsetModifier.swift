//
//  OffsetModifier.swift
//  StickyHeader
//
//  Created by Kyubo Shim on 2022/10/22.
//

import SwiftUI

struct OffsetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geo -> Color in
                    // getting value for coordinate space called scroll
                    let minY = geo.frame(in: .named("SCROLL")).minY
                    
                    DispatchQueue.main.async {
                        self.offset = minY
                    }
                    
                    return Color.clear
                }
                , alignment: .top
            )
        
    }
}

struct OffsetModifier2: ViewModifier {
    @Binding var offset: CGFloat
    
    var returnFromStart: Bool = true
    @State var startValue: CGFloat = 0
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    Color.white
                        .preference(key: OffsetKey.self, value: geo.frame(in: .named("SCROLL")).minY)
                        .onPreferenceChange(OffsetKey.self) { value in
                            if startValue == 0 {
                                startValue = value
                            }
                            
                            offset = (value - (returnFromStart ? startValue : 0))
                        }
                }
            }
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
