//
//  LaunchScreenView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/19.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Color("MainColor")
            Image("WhiteAppTitle")
                .resizable()
                .frame(width: 250, height: 75)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
