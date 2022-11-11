//
//  CategoryButtonView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct CategoryButtonView: View {
    let imageName: String
    let title: String
    
    var body: some View {
        VStack {
            // MARK: - 카테고리 아이콘
            Image(imageName)
            // MARK: - 카테고리 명
            Text(title)
                .customSubhead3()
        }
        .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(86))
    }
}

struct CategoryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonView(imageName: "Bada", title: "바다와 함께")
    }
}
