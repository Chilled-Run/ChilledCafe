//
//  VisitPostView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import SwiftUI

struct VisitPostView: View {
    let pawColor = footKind.bearPaw.footColor
    let pawBackgroundColor = footKind.bearPaw.footBackground
    
    var body: some View {
            VStack(alignment: .leading) {
                //첫번째 문단
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("12번째 방문한")
                            .customTitle1()
                        Text("아이디")
                            .customLargeTitle()
                            .padding(.top, UIScreen.getHeight(10))
                        Text("2022.11.17 다녀감")
                            .customSubhead3()
                            .padding(.top, UIScreen.getHeight(10))
                    }
                    .foregroundColor(pawColor)
                    Spacer()
                    Image("bearPaw")
                        .resizable()
                        .frame(width: 90, height: 90)
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                //두번째 문단
                VStack(alignment: .leading) {
                    Text("사장님,")
                        .customSubhead4()
                    Text("딸기 말고 다른 맛은")
                        .customSubhead4()
                    Text("만드실 생각")
                        .customSubhead4()
                    Text("없으신지요?")
                        .customSubhead4()
                    Spacer()
                }
                .foregroundColor(Color.white)
                .frame(height: UIScreen.getHeight(100))
                .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                //세번째 문단
                Spacer()
                HStack {
                    Image(systemName: "heart")
                    Text("999+")
                    Image(systemName: "message")
                    Text("999+")
                    Spacer()
                }
                .foregroundColor(pawColor)
                .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: 0, trailing:UIScreen.getWidth(30)))
                
                // 구분선
                Rectangle()
                    .fill(pawColor)
                    .frame(height: 2)
                    .edgesIgnoringSafeArea(.horizontal)
                    .padding(.top, UIScreen.getHeight(10))

                //댓글 문단
                VStack(alignment: .leading, spacing: 6) {
                        Text("아이디")
                        .foregroundColor(pawColor)
                        .customSubhead2()
            
                        Text("어떤걸로 해드릴까요")
                        .foregroundColor(Color.white)
                        .customSubhead4()
                }
                .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(30), bottom: UIScreen.getHeight(20), trailing:UIScreen.getWidth(30)))
            }
            .frame(width: 340, height: 420)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(pawBackgroundColor, lineWidth: 2)
            )
            .background(pawBackgroundColor)
        
    }
}

struct VisitPostView_Previews: PreviewProvider {
    static var previews: some View {
        VisitPostView()
    }
}

//발자국 종류에 따른 색 변경
enum footKind {
    case bearPaw
    case birdFoot
    case catPaw
    case dogFoot
    case duckFoot
    case horsePaw
    case leftFoot
    case rightFoot
    
    var footColor: Color {
        switch self {
        //return mainColor
        case .leftFoot:
            return Color("MainColor")
        case .bearPaw:
            return Color("MainColor")
        case .birdFoot:
            return Color("MainColor")
        case .rightFoot:
            return Color("MainColor")
         
        //return CustomGreen
        case .catPaw:
            return Color("CustomGreen")
        case .dogFoot:
            return Color("CustomGreen")
        case .duckFoot:
            return Color("CustomGreen")
        case .horsePaw:
            return Color("CustomGreen")
        }
    }
    
    var footBackground: Color {
        switch self {
        //return pastelBlue
        case .leftFoot:
            return Color("pastelBlue")
        case .bearPaw:
            return Color("pastelBlue")
        case .birdFoot:
            return Color("pastelBlue")
        case .rightFoot:
            return Color("pastelBlue")
         
        //return pastelGreen
        case .catPaw:
            return Color("pastelGreen")
        case .dogFoot:
            return Color("pastelGreen")
        case .duckFoot:
            return Color("pastelGreen")
        case .horsePaw:
            return Color("pastelGreen")
        }
    }
}
