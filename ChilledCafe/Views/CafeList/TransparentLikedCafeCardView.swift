//
//  LikedCafeCardView2.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/25.
//

import SwiftUI
import Kingfisher

struct TransparentLikedCafeCardView: View {
    var thumbnail: String
    var name: String
    var shortIntroduction: String
    
    var body: some View {
        KFImage(URL(string: thumbnail))
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(200))
            .cornerRadius(4)
            .overlay {
                    VStack {
                        Spacer()
                            ZStack {
                                Color.white.opacity(0.8)
                                VStack {
                                    HStack {
                                        Text(name)
                                            .customTitle1()
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: 0, bottom: UIScreen.getHeight(4), trailing: 0))
                                    HStack {
                                        Text(shortIntroduction)
                                            .customSubhead1()
                                        Spacer()
                                    }
                                }
                                .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(10), bottom: 0, trailing: 0))
                            }
                            .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(80))
                    }
            }
            .cornerRadius(4)
    }
}

struct TransparentLikedCafeCard_Previews: PreviewProvider {
    static var previews: some View {
        TransparentLikedCafeCardView(thumbnail: "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/tempThumbnail.png?alt=media&token=57aa6138-8276-47e8-adb1-1d6a5ba5379a", name: "아리바리카커피로스터스", shortIntroduction: "멋진카페")
    }
}
