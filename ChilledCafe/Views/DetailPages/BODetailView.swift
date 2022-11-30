//
//  BODetailView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/13.
//


import SwiftUI
import Kingfisher
import ACarousel


struct BODetailView: View {
    @State var halfModal_shown: Bool = false
    let cafe: Cafes
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            //스크롤 뷰 고정
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    
                    //carousel nav
                    CarouselView(cafe: cafe)
                    
                    //공간의 특징
                    DetailInfoView(sample: cafe)
                    
                    //MARK: 카페 위치정보
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("위치")
                            .customTitle2()
                        HStack {
                            Image("place")
                                .resizable()
                                .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                                .foregroundColor(Color("MainColor"))
                            Text(cafe.location)
                                .customBody()
                                .foregroundColor(Color("CustomGray1"))
                            Spacer()
                            
                            //지도 모달로 이어지는 버튼
                            Button(action: {halfModal_shown.toggle()}) {
                                Text("길찾기")
                                    .foregroundColor(Color("MainColor"))
                                    .frame(width: UIScreen.getWidth(62) ,height: UIScreen.getHeight(35))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 4)
                                            .stroke(Color("MainColor"), lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                    
                    //방문자 로그 뷰
                    GuestLogView()
                    
                    Spacer()
                }
                
            }
            
            HalfModalView(isShown: $halfModal_shown, modalHeight: UIScreen.getHeight(313)){
                VStack{}
            }
        
            // MARK: 플로팅 버튼
            VStack {
                HStack {
                    backButton
                    Spacer()
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(57), leading: UIScreen.getWidth(17), bottom: 0, trailing: 0))
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(34), trailing: UIScreen.getWidth(20)))
        }
        .ignoresSafeArea(.all)
    }
    
    var backButton : some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .foregroundColor(Color.white)
                    .frame(width: UIScreen.getWidth(10) ,height: UIScreen.getHeight(19))
            }
            
        }
    }
    
    // MARK: AR 버튼
    
    var arButtonView : some View {
        Circle()
            .fill(Color("MainColor"))
            .frame(width: UIScreen.getWidth(60), height: UIScreen.getWidth(60))
            .overlay(
                Image("ar")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color.white)
            )
            .shadow(radius: 4, x: 0, y: 4)
        
    }
}

struct BODetailView_Previews: PreviewProvider {
    static var previews: some View {
        BODetailView(cafe: constant().sample)
    }
}


