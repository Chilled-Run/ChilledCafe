//
//  FullCardView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/11.
//

import SwiftUI
import Kingfisher

struct FullCardView: View {
    @State var cafe: Cafes = constant().sample
    var firebaseSM: FirebaseStorageManager
    var index: Int

    var body: some View {
        KFImage(URL(string: cafe.thumbnail))
            .placeholder{
                ProgressView().progressViewStyle(CircularProgressViewStyle())
            }
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(250))
            .cornerRadius(4, corners: .allCorners)
            .overlay(content: {
                ZStack {
                    Color.black
                        .opacity(0.4)
                        .cornerRadius(4, corners: .allCorners)
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
                                    cafe.toggleBookmark()
                                    firebaseSM.toggleBookmark(index: index)
                                }, label: {
                                    Image("bookmarkToggled")
                                        .resizable()
                                        .frame(width: UIScreen.getWidth(30), height: UIScreen.getHeight(30))
                                        .foregroundColor(Color(.orange))
                                })
                            } else {
                                Button(action: {
                                    // TODO: 북마크 토글 동작
                                    cafe.toggleBookmark()
                                    firebaseSM.toggleBookmark(index: index)
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
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.white)
                            Spacer()
                        }
                        
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
                }
            })
            .onAppear() {
                cafe = firebaseSM.getSelectedCafe(index: index)
            }
    }  
}

//struct FullCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCardView(imageURL: "")
//    }
//}
