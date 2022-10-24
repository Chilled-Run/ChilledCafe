//
//  Menu.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/23.
//

import SwiftUI

struct Menu: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("menu")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
        }
        .padding(.horizontal)
        .padding(.bottom, 150)
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
