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
            KFImage(URL(string: cafe.menuImages[0]))
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
        }
        .padding(.horizontal)
        .padding(.bottom, 150)
    }
}

//struct Menu_Previews: PreviewProvider {
//    static var previews: some View {
//        Menu()
//    }
//}