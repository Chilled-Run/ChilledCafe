//
//  CarouselView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/30.
//

import SwiftUI
import Kingfisher
import ACarousel

struct CarouselView: View {
    @State var currentIndex: Int = 0
    @Environment(\.presentationMode) var presentationMode
    
    let cafe: Cafe
    var body: some View {
        VStack {
            //carousel nav
            NavigationLink(destination: MoodView(images: cafe.moodImages )) {
                
                ZStack(alignment: .top) {
                    
                    // MARK: 카페 캐러셀 이미지
                    ACarousel(cafe.moodImages, id: \.self, index: $currentIndex, spacing: 0, headspace: 0, sidesScaling: 1, isWrap: false, autoScroll: .inactive) {_ in
                        KFImage(URL(string: cafe.moodImages[currentIndex]))
                            .placeholder{
                                ProgressView().progressViewStyle(CircularProgressViewStyle())
                            }
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.getHeight(390))
                    }
                    VStack {
                        //gradient effect
                        Image("gradient")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.getHeight(111))
                        
                        Spacer()
                        // MARK: 캐러셀 인덱스
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .opacity(0.4)
                                .frame(width:UIScreen.getWidth(42), height:UIScreen.getHeight(24))
                                .overlay(
                                    Text("\(currentIndex + 1)" + "/" + "\(cafe.moodImages.count)")
                                        .customSubhead3()
                                        .foregroundColor(Color.white)
                                )
                        }
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(20), trailing: UIScreen.getWidth(20)))
                    }
                }
                
                //carousel height
                .frame(height: UIScreen.getHeight(390))
                
            }
        }
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView(cafe: constant().sample)
    }
}
