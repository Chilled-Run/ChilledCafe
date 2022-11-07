//
//  Menu.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/23.
//

import SwiftUI
import Kingfisher

struct Menu: View {
    let cafe: Cafe
    var body: some View {
        VStack(alignment: .center) {
            KFImage(URL(string: cafe.menuImages[0])).placeholder{
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.screenWidth - 40, alignment: .center)
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("CustomGray3"), lineWidth: 1))
            
            
            Spacer()
        }
        .padding(.top, 80)
        .padding(.horizontal)
    }
}

