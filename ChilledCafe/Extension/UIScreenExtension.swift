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

extension Font {
    static func setSize() -> Double {
        let height = UIScreen.screenHeight
        var size = 1.0

        switch height {
        case 480.0: //Iphone 3,4S => 3.5 inch
            size = 0.85
            break
        case 568.0: //iphone 5, SE => 4 inch
            size = 0.9
            break
        case 667.0: //iphone 6, 6s, 7, 8 => 4.7 inch
            size = 0.9
            break
        case 736.0: //iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            size = 0.95
            break
        case 812.0: //iphone X, XS => 5.8 inch, 13 mini, 12, mini
            size = 0.98
            break
        case 844.0: // iphone 14, iphone 13 pro, iphone 13, 12 pro, 12
            size = 1
            break
        case 852.0: // iphone 14 pro
            size = 1
            break
        case 926.0: // iphone 14 plus, iphone 13 pro max, 12 pro max
            size = 1.05
            break
        case 896.0: //iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch, 11 pro max, 11
            size = 1.05
            break
        case 932.0: // iPhone14 Pro Max
            size = 1.08
            break
        default:
            size = 1
            break
        }
        return size
    }
}
