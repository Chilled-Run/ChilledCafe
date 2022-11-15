//
//  DetailInfoView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/13.
//

import SwiftUI

struct DetailInfoView: View {
    @State var sample: Cafes = constant().sample
    var firebaseSM: FirebaseStorageManager
    var index: Int
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // MARK: 카페 타이틀과 북마크, 한 줄 소개
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(sample.name)
                        .customTitle3()
                    Spacer()
                    Button(action: {
                        sample.toggleBookmark()
                        firebaseSM.toggleBookmark(index: index)
                    }) {
                        if sample.bookmark {
                            Image("bookmarkToggled")
                                .resizable()
                                .frame(width:UIScreen.getWidth(30), height:UIScreen.getHeight(30))
                                .foregroundColor(Color("SubColor"))
                        }
                        else {
                            Image("bookmarkEmpty")
                                .resizable()
                                .frame(width:UIScreen.getWidth(30), height:UIScreen.getHeight(30))
                                .foregroundColor(Color.black)
                        }
                    }
                }
                HStack {
                    Text(sample.shortIntroduction)
                        .customBody()
                        .foregroundColor(Color("CustomGray1"))
                }
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            
            // MARK: divider
            
            Rectangle()
                .fill(Color("CustomGray3"))
                .frame(height: UIScreen.getHeight(2))
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.top, UIScreen.getHeight(20))
            
            DetailTagView(sample: sample)
            
            // MARK: 공간의 특징
            
            HStack {
                VStack(alignment: .leading, spacing: 20) {
                    Text("이 공간의 특별함")
                        .customTitle2()
                    // 공간에 대한 특징
                    ForEach(sample.cafeInfo, id: \.self) {
                        info in
                        HStack(alignment:.top ) {
                            Image("orange")
                                .resizable()
                                .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                .foregroundColor(Color("MainColor"))
                            VStack {
                                Text(info)
                                    .customBody()
                                    .foregroundColor(Color("CustomGray1"))
                                    .lineLimit(3)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            
            //MARK: 카페 위치정보
            
            VStack(alignment: .leading, spacing: 20) {
                Text("위치")
                    .customTitle2()
                HStack {
                    Image("place")
                        .resizable()
                        .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                        .foregroundColor(Color("MainColor"))
                    Text(sample.location)
                        .customBody()
                        .foregroundColor(Color("CustomGray1"))
                    Spacer()
                }
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
        }
        .onAppear() {
            sample = firebaseSM.getSelectedCafe(index: index)
        }
    }
}

//struct DetailInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailInfoView(sample: constant().sample)
//    }
//}

