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
    let sample = Cafes(name: "꾸꾸하우스", shortIntroduction: "에스프레소 맛에 진심인 카페", thumbnail: "OnboardingImage1", moodImages: ["OnboardingImage1","OnboardingImage2","OnboardingImage3","OnboardingImage4","OnboardingImage5"], cafeInfo: ["테라스에 앉아 바다를 배경으로 그림 그리기","낮에는 커피를 팔고 밤에는 술을 파는 곳","AR 컨텐츠르로 다양한 공간 스토리를 볼 수 있는 곳"], bookmark: true, ar: true, tag: ["바다와 함께","AR 경험"], location: "포항시 남구 지곡로 82", businessHour: [""])
    
    var body: some View {
        GeometryReader {geo in
            ZStack{
                VStack {
                    carouselView
                    titleView
                    Divider()
                        .padding(.top, 20)
                    tagView
                    infoView
                    locationView
                }.ignoresSafeArea(.all)
                VStack{
                    HStack{
                        Spacer()
                        indexView
                            .padding(EdgeInsets(top: 57, leading: 0, bottom: 0, trailing: 20))
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        arButton
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 34, trailing: 20))
                }
            }
        }.ignoresSafeArea(.all)
    }
}
struct BlueOrangeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BlueOrangeDetailView()
    }
}
extension BlueOrangeDetailView{
    var carouselView: some View{
        ZStack(alignment: .top) {
            ACarousel(sample.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .active(5)) {_ in
                ZStack{
                    //                                KFImage(URL(string: sample.moodImages[currentIndex]))
                    Image(sample.moodImages[currentIndex])
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(300))
                        .overlay(content: {
                            Color.black
                                .opacity(0.5)
                        })
                }
            }
            .frame(height: UIScreen.getHeight(300))
        }
    }
}

extension BlueOrangeDetailView{
    var titleView: some View{
        VStack(alignment: .leading, spacing: 10){
            HStack{
                Text(sample.name + " 카페")
                    .customTitle3()
                Spacer()
                Image("바다와 함께")
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(Color.red)
                    .frame(width:30, height:30)
                
            }
            HStack{
                Text(sample.shortIntroduction)
                    .customBody()
                    .foregroundColor(Color("CustomGray1"))
            }
        }
        .frame(maxWidth: .infinity)
        .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
    }
}

extension BlueOrangeDetailView{
    var tagView: some View{
        HStack{
            ForEach(sample.tag, id: \.self){
                tag in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color("MainColor"))
                    .frame(height: 31)
                    .overlay(
                        HStack{
                            Image("바다와 함께")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(Color.white)
                                .frame(width: 24, height: 24)
                            
                            Text(tag)
                                .customSubhead3()
                                .foregroundColor(Color.white)
                        }
                    )
            }
        }.padding(EdgeInsets(top: 20, leading: 20, bottom: 0, trailing: 20))
    }
}




extension BlueOrangeDetailView{
    var infoView: some View{
        VStack(alignment: .leading, spacing: 20){
            Text("이 공간의 특별함")
                .customTitle2()
            ForEach(sample.cafeInfo, id: \.self){
                info in
                HStack{
                    Image("바다와 함께")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text(info)
                        .customBody()
                        .foregroundColor(Color("CustomGray1"))
                }
            }
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))
    }
}

extension BlueOrangeDetailView{
    var locationView: some View{
        VStack(alignment: .leading, spacing: 20 ){
            Text("위치")
                .customTitle2()
            HStack{
                Image("바다와 함께")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text(sample.location)
                    .customBody()
                    .foregroundColor(Color("CustomGray1"))
                Spacer()
            }
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 20))    }
}

extension BlueOrangeDetailView{
    var indexView: some View{
        HStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("CustomGray2"))
                .frame(width:40, height:24)
                .overlay(
                    Text("\(currentIndex)" + "/" + "\(sample.moodImages.count)")
                        .customSubhead3()
                )
        }
    }
}

extension BlueOrangeDetailView{
    var arButton: some View{
        VStack{
            Button(action: {}){
                Image("바다와 함께")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(radius: 3)
            }
        }
    }
}
