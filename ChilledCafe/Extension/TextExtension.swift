//
//  TextExtension.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/24.
//

import SwiftUI

//Optima-Regular
//Optima-Italic
//Optima-Bold
//Optima-BoldItalic
//Optima-ExtraBlack
//
//
//AppleSDGothicNeo-Regular
//AppleSDGothicNeo-Thin
//AppleSDGothicNeo-UltraLight
//AppleSDGothicNeo-Light
//AppleSDGothicNeo-Medium
//AppleSDGothicNeo-SemiBold
//AppleSDGothicNeo-Bold
//AppleSDGothicNeoEB00

extension Text {
    func customLargeTitle() -> some View {
        self.font(.custom("AppleSDGothicNeo-Bold", size: 30))
    }
    
    func customTitle3() -> some View {
        self.font(.custom("AppleSDGothicNeoEB00", size: 24))
    }
    
    func customTitle2() -> some View {
        self.font(.custom("AppleSDGothicNeo-Bold", size: 20))
    }
    
    func customTitle1() -> some View {
        self.font(.custom("AppleSDGothicNeo-SemiBold", size: 16))
    }
    
    func customHeadline() -> some View {
        self.font(.custom("AppleSDGothicNeo-Medium", size: 20))
    }
    
    func customSubhead4() -> some View {
        self.font(.custom("AppleSDGothicNeo-Medium", size: 16))
    }
    
    func customSubhead3() -> some View {
        self.font(.custom("AppleSDGothicNeo-Light", size: 14))
    }
    
    func customSubhead2() -> some View {
        self.font(.custom("AppleSDGothicNeo-Regular", size: 12))
    }
    
    func customSubhead1() -> some View {
        self.font(.custom("AppleSDGothicNeo-Light", size: 12))
    }
    
    func customBody() -> some View {
        self.font(.custom("AppleSDGothicNeo-Regular", size: 16))
    }
    
    func CustomDesignedTitle() -> some View {
        self.font(.custom("LTMuseum-Bold", size: 20))
    }

    func CustomDesignedBody() -> some View {
        self.font(.custom("LTMuseum-Medium", size: 16))
    }
}


