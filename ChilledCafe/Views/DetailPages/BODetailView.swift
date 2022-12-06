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
    //지도 모달
    @State var halfModal_shown: Bool = false
    //화면이 밑으로 내려가는 것을 체크하기 위한 timer
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    //캐러셀 밑으로 내려가면 true
    @State var checkingNavigationBar = false
    let cafe: Cafe

    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack {
            //스크롤 뷰 고정
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 0) {
                    GeometryReader {
                        geo in
                        //carousel nav
                        CarouselView(cafe: cafe)
                            .offset(y: geo.frame(in: .global).minY > 0 ? -geo.frame(in: .global).minY : 0 )
                            .frame(height: geo.frame(in: .global).minY > 0 ? UIScreen.getHeight(390) + geo.frame(in: .global).minY : UIScreen.getHeight(390))
                            .onReceive(self.time) { (_) in
                                // 화면 위치 체크
                                let y = geo.frame(in: .global).minY
                                if -y > (UIScreen.getHeight(390) - UIScreen.getHeight(100)) {
                                    checkingNavigationBar = true
                                }
                                else {
                                    checkingNavigationBar = false
                                }
                            }
                    }
                    .frame(height: UIScreen.getHeight(390))
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
                                    .customSubhead4()
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
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
            // scrollView 끝
            
            
            // 모달 뷰
            HalfModalView(isShown: $halfModal_shown, modalHeight: UIScreen.getHeight(313)){
                VStack{}
            }
            
            // MARK: 플로팅 버튼
            // true라면 navigationBar를 불러와 백버튼과 이름 추가
            if checkingNavigationBar {
                VStack{}
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(cafe.name, displayMode: .inline)
                    .navigationBarItems(leading: backButton)
            }
            else {
                // false면 맨위 흰색 뒤로가기 버튼만
                VStack {
                    HStack {
                        backButton
                        Spacer()
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(57), leading: UIScreen.getWidth(17), bottom: 0, trailing: 0))
                    Spacer()
                }
                .navigationBarHidden(true)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(34), trailing: UIScreen.getWidth(20)))
            }
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
                    .foregroundColor(checkingNavigationBar ? Color("MainColor"): Color.white)
                    .frame(width: UIScreen.getWidth(10) ,height: UIScreen.getHeight(19))
            }
        }
    }
    
}

struct BODetailView_Previews: PreviewProvider {
    static var previews: some View {
        BODetailView(cafe: constant().sample)
    }
}


