//
//  CategoryButtonView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct CategoryButtonView: View {
    let title: String
    
    var body: some View {
        VStack {
            // MARK: - 카테고리 아이콘
            Image("\(Icon(rawValue: title) ?? .ocean)")
            // MARK: - 카테고리 명
            Text(title)
                .customSubhead3()
        }
        .frame(width: UIScreen.getWidth(80), height: UIScreen.getHeight(86))
    }
}

enum Icon: String {
    case animal = "동물과 함께"
    case antique = "고풍스러운"
    case ar = "AR 경험"
    case forest = "숲을 거닐며"
    case large = "거대한 공간"
    case ocean = "바다와 함께"
    case oriental = "동양풍"
    case outdoor = "야외가 있는"
    case river = "리버뷰"
    case stair = "층별로 다른"
}

struct CategoryButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryButtonView(title: "바다와 함께")
    }
}
