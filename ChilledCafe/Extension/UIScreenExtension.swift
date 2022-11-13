//
//  UIScreenExtension.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/21.
//
import SwiftUI

extension UIScreen {

    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size

    static func getWidth(_ width: CGFloat) -> CGFloat {
        screenWidth / 390 * width
    }

    static func getHeight(_ height: CGFloat) -> CGFloat {
        screenHeight / 844 * height
    }
    
}
