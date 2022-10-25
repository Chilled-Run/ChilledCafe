//
//  LikedCafeCardView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/23.
//

import SwiftUI
import Kingfisher

struct LikedCafeCardView: View {
    var thumbnail: String
    var name: String
    var shortIntroduction: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .stroke(Color.orange, lineWidth: 1)
            .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(200))
            .overlay {
                ZStack {
                    Color.white
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("CustomGray3"), lineWidth: 1)
                        .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(200))
                    VStack {
                        KFImage(URL(string: thumbnail))
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(120))
                            .cornerRadius(4, corners: .topRight)
                            .cornerRadius(4, corners: .topLeft)
                        
                        Group {
                            HStack {
                                Text(name)
                                    .customTitle1()
                                Spacer()
                            }
                            .padding(EdgeInsets(top: UIScreen.getHeight(10), leading: 0, bottom: UIScreen.getHeight(4), trailing: 0))
                            HStack {
                                Text(shortIntroduction)
                                    .customSubhead1()
                                    .foregroundColor(Color("CustomGray1"))
                                Spacer()
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(10), bottom: 0, trailing: 0))
                        Spacer()
                    }
                }
            }
            .cornerRadius(4)
    }
}

struct LikedCafeCardView_Previews: PreviewProvider {
    static var previews: some View {
        LikedCafeCardView(thumbnail: "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/tempThumbnail.png?alt=media&token=57aa6138-8276-47e8-adb1-1d6a5ba5379a", name: "아리바리카커피로스터스", shortIntroduction: "멋진카페")
    }
}
