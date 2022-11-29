//
//  DetailInfoView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/13.
//

import SwiftUI

struct DetailInfoView: View {
    let sample: Cafes
    var body: some View {
        
        VStack(spacing: 0) {
            
            
            // 테그 추가
            DetailTagView(sample: sample)
            
            // MARK: 카페 타이틀과 북마크, 한 줄 소개
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(sample.name)
                        .customTitle3()
                    Spacer()
                    Button(action: {}) {
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
            .padding(EdgeInsets(top: UIScreen.getHeight(16), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            
            // MARK: divider
            
            Rectangle()
                .fill(Color("CustomGray3"))
                .frame(height: UIScreen.getHeight(2))
                .edgesIgnoringSafeArea(.horizontal)
                .padding(.top, UIScreen.getHeight(20))
            
            
            // MARK: 공간의 특징
            
            // 임시구현!!
            // 데이터 구조 변경 후 수정
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text("공간의 특징")
                        .customTitle2()
                        .padding(.bottom, UIScreen.getHeight(10))
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 0) {
                            HStack {
                                Image("mood")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                Text("분위기")
                                    .customTitle1()
                                    .foregroundColor(Color("MainColor"))
                            }
                            Text(sample.cafeInfo[0])
                                .customSubhead3()
                                .foregroundColor(Color("CustomGray1"))
                                .padding(.top, UIScreen.getHeight(10))
                            
                            HStack {
                                Image("menu")
                                    .resizable()
                                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                Text("시그니처 메뉴")
                                    .customTitle1()
                                    .foregroundColor(Color("MainColor"))
                            }
                            .padding(.top, UIScreen.getHeight(20))
                            
                            Text(sample.cafeInfo[1])
                                .customSubhead3()
                                .foregroundColor(Color("CustomGray1"))
                                .padding(.top, UIScreen.getHeight(10))
                        }
                        Spacer()
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: UIScreen.getHeight(20), trailing: 0))
                    .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("CustomGray3"), lineWidth: 2)
                    )
                    .background(Color("CustomGray3"))
                       
                    
                   
                    
//                    ForEach(sample.cafeInfo, id: \.self) {
//                        info in
//                        HStack(alignment:.top ) {
//                            Image("orange")
//                                .resizable()
//                                .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
//                                .foregroundColor(Color("MainColor"))
//                            VStack {
//                                Text(info)
//                                    .customBody()
//                                    .foregroundColor(Color("CustomGray1"))
//                                    .lineLimit(3)
//                                    .fixedSize(horizontal: false, vertical: true)
//                            }
//                        }
//                    }
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
                    
                    //지도 모달로 이어지는 버튼
                    Button(action: {}){//
                        Text("길찾기")
                    }
                }
            }
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
        }
    }
}

struct DetailInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DetailInfoView(sample: constant().sample)
    }
}

