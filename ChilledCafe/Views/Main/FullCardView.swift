//
//  FullCardView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/11.
//

import SwiftUI
import Kingfisher

struct FullCardView: View {
    let cafe: Cafes

    var body: some View {
        KFImage(URL(string: cafe.thumbnail))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(250))
            .cornerRadius(4, corners: .allCorners)
            .overlay(content: {
                VStack {
                    HStack(spacing: 16) {
                        Spacer()
                        // MARK: - AR 토글 여부
                        if cafe.ar {
                            Button(action: {
                                // TODO: AR 토글 동작
                            }, label: {
                                Image("ar")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                                    .foregroundColor(.white)
                            })
                        }
                        // MARK: - 북마크 토글 여부
                        if cafe.bookmark {
                            Button(action: {
                                // TODO: 북마크 토글 동작
                            }, label: {
                                Image("bookmarkToggled")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                                    .foregroundColor(Color(.orange))
                            })
                        } else {
                            Button(action: {
                                // TODO: 북마크 토글 동작
                            }, label: {
                                Image("bookmarkBlack")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                                    .foregroundColor(Color(.white))
                            })
                        }
                    }
                    Spacer()
                    // MARK: - 카페 이름
                    HStack {
                        Text(cafe.name)
                            .customTitle2()
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(6), trailing: 0))
                    // MARK: - 카페 설명
                    HStack {
                        Text(cafe.shortIntroduction)
                            .customSubhead3()
                            .foregroundColor(.white)
                        Spacer()
                    }
                       
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
            })
    }  
}

//struct FullCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCardView(imageURL: "")
//    }
//}
