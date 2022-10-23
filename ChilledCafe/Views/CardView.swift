//
//  CardView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/23.
//

import SwiftUI
import Kingfisher

struct CardView: View {
    var thumbnail: String
    var name: String
    var shortIntroduction: String
    
    var body: some View {
        ZStack {
            KFImage(URL(string: thumbnail))
                .resizable()
                .cornerRadius(4)
                .frame(width: UIScreen.getWidth(160), height: UIScreen.getHeight(250))
                .overlay {
                    ZStack {
                        Color.black
                            .opacity(0.5)
                        VStack(alignment: .leading) {
                            
                            HStack {
                                Text(name)
                                    .lineLimit(1)
                                Spacer()
                            }
                            .padding(EdgeInsets(top: UIScreen.getHeight(164), leading: 0, bottom: UIScreen.getHeight(5), trailing: 0))
                            HStack {
                                Text(shortIntroduction)
                                    .font(.system(size: 13))
                                    .lineSpacing(1)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Spacer()
                            }
                            Spacer()
                        }
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(10), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(10)))
                    }
                }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(thumbnail: "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/tempThumbnail.png?alt=media&token=57aa6138-8276-47e8-adb1-1d6a5ba5379a", name: "아리바리카커피로스터스", shortIntroduction: "멋진카페")
    }
}
