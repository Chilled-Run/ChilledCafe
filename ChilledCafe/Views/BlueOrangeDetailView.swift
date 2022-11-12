//
//  BlueOrangeDetailView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/10.
//

import SwiftUI
import Kingfisher
import ACarousel

struct BlueOrangeDetailView: View {
    @State var currentIndex: Int = 0
    let sample = Cafes(name: "꾸꾸하우스", shortIntroduction: "에스프레소 맛에 진심인 카페", thumbnail: "OnboardingImage1", moodImages: ["https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F11.jpg?alt=media&token=ad6aaf6d-e13a-4d2c-b290-f7475a7d2b8b", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F11.jpg?alt=media&token=ad6aaf6d-e13a-4d2c-b290-f7475a7d2b8b",
                                                                                                                        "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313",], cafeInfo: ["테라스에 앉아 바다를 배경으로 그림 그리기","낮에는 커피를 팔고 밤에는 술을 파는 곳","AR 컨텐츠르로 다양한 공간 스토리를 볼 수 있는 곳"], bookmark: true, ar: true, tag: ["바다와 함께","바다와 함께"], location: "포항시 남구 지곡로 82", businessHour: [""])
    init() {
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                ZStack{
                    VStack(spacing: 0) {
                        carouselView
                        titleView
                        dividerView
                        tagView
                        infoView
                        locationView
                        Spacer()
                    }
                    .frame(height: UIScreen.getHeight(810))
                    .ignoresSafeArea(.all)
                    VStack{
                        HStack{
                            Spacer()
                            indexView
                        }
                        Spacer()
                        HStack{
                            Spacer()
                            if sample.ar {
                                arButton
                            }
                        }.padding(EdgeInsets(top: UIScreen.getHeight(0), leading: UIScreen.getWidth(0), bottom: UIScreen.getWidth(0), trailing: UIScreen.getWidth(20)))
                    }
                }
            }.ignoresSafeArea(.all)
        }.ignoresSafeArea(.all)
    }
}
struct BlueOrangeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlueOrangeDetailView()
    }
}

// MARK: 캐러셀
private extension BlueOrangeDetailView{
    var carouselView: some View{
        ZStack(alignment: .top) {
            NavigationLink(destination: MoodView(images: sample.moodImages )){
                ZStack(alignment: .top){
                    ACarousel(sample.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) {_ in
                        KFImage(URL(string: sample.moodImages[currentIndex]))
                            .placeholder{
                                ProgressView().progressViewStyle(CircularProgressViewStyle())
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(300))
                    }
                    Image("gradient")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.getHeight(111))
                }
                .frame(height: UIScreen.getHeight(300))
            }
        }
    }
}

// MARK: 카페의 이름,북마크, 짧은 소개
private extension BlueOrangeDetailView{
    var titleView: some View{
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(sample.name + " 카페")
                    .customTitle3()
                Spacer()
                
                if sample.bookmark {
                    Image("bookmarkToggled")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color("SubColor"))
                        .frame(width:UIScreen.getWidth(30), height:UIScreen.getHeight(30))
                }
                else {
                    Image("bookmarkBlack")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.black)
                        .frame(width:UIScreen.getWidth(30), height:UIScreen.getHeight(30))
                }
            }
            HStack{
                Text(sample.shortIntroduction)
                    .customBody()
                    .foregroundColor(Color("CustomGray1"))
            }
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}
private extension BlueOrangeDetailView{
    var dividerView: some View{
        Rectangle()
            .fill(Color("CustomGray3"))
            .frame(height: UIScreen.getHeight(2))
            .edgesIgnoringSafeArea(.horizontal)
            .padding(.top, UIScreen.getHeight(20))
    }
}


// MARK: 해당 카페의 태그들을 보여주느 뷰
private extension BlueOrangeDetailView{
    var tagView: some View{
        HStack{
            ForEach(sample.tag, id: \.self){
                tag in
                HStack(spacing: 0){
                    Image("바다와 함께")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .frame(width: UIScreen.getWidth(24), height: UIScreen.getHeight(24))
                        .padding(.leading, 10)
                    
                    Text(tag)
                        .customSubhead3()
                        .foregroundColor(Color.white)
                        .padding(.leading, 6)
                        .padding(.trailing, 10)
                }
                .frame(height: UIScreen.getHeight(31))
                .background(Color("MainColor"))
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color("MainColor"), lineWidth: 2)
                )
                
            }
            Spacer()
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}

// MARK: 카페의 정보를 보여주는 뷰
private extension BlueOrangeDetailView{
    var infoView: some View{
        HStack{
            VStack(alignment: .leading, spacing: 20){
                Text("이 공간의 특별함")
                    .customTitle2()
                ForEach(sample.cafeInfo, id: \.self){
                    info in
                    HStack(alignment:.top ){
                        Image("orange")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color("MainColor"))
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                        VStack{
                            Text(info)
                                .customBody()
                                .foregroundColor(Color("CustomGray1"))
                                .lineLimit(2)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
            Spacer()
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}

// MARK: 위치정보
private extension BlueOrangeDetailView{
    var locationView: some View{
        VStack(alignment: .leading, spacing: 20 ){
            Text("위치")
                .customTitle2()
            HStack{
                Image("place")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color("MainColor"))
                    .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                Text(sample.location)
                    .customBody()
                    .foregroundColor(Color("CustomGray1"))
                Spacer()
            }
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))    
    }
}

// MARK: 캐러셀의 사진 개수와 현재 인덱스를 보여주는 뷰
private extension BlueOrangeDetailView{
    var indexView: some View{
        HStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.black)
                .opacity(0.4)
                .frame(width:UIScreen.getWidth(42), height:UIScreen.getHeight(24))
                .overlay(
                    Text("\(currentIndex + 1)" + "/" + "\(sample.moodImages.count)")
                        .customSubhead3()
                        .foregroundColor(Color.white)
                )
        } 
        .padding(EdgeInsets(top: UIScreen.getHeight(256), leading: 0, bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}

// MARK: ar기능을 위한 플로팅 버튼
private extension BlueOrangeDetailView{
    var arButton: some View{
        VStack{
            Button(action: {}){
                Circle()
                    .fill(Color("MainColor"))
                    .frame(width: UIScreen.getWidth(60), height: UIScreen.getWidth(60))
                    .overlay(
                        Image("ar")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                    )
                    .shadow(radius: 4, x: 0, y: 4)
            }
        }
    }
}
