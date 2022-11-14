//
//  NavigationBarModifier.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/14.
//
import SwiftUI
import Foundation

struct NavigationBarColorModifier<Background>: ViewModifier where Background: View {
    
    let background: () -> Background
    
    public init(@ViewBuilder background: @escaping () -> Background) {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        UINavigationBar.appearance().compactAppearance = coloredAppearance

        self.background = background
    }

    func body(content: Content) -> some View {
        // Color(UIColor.secondarySystemBackground)
        ZStack {
            content
            VStack {
                background()
                    .edgesIgnoringSafeArea([.top, .leading, .trailing])
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 0, alignment: .center)

                Spacer() // to move the navigation bar to top
            }
        }
    }
}

public extension View {
    func navigationBarBackground<Background: View>(@ViewBuilder _ background: @escaping () -> Background) -> some View {
        modifier(NavigationBarColorModifier(background: background))
    }
}
