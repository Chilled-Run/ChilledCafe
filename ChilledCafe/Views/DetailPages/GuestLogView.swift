//
//  GuestLogView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/30.
//

import SwiftUI

struct GuestLogView: View {
    var body: some View {
        VStack(spacing: UIScreen.getHeight(20)) {
            VStack(alignment: .center) {
                HStack {
                    Text("방문자 로그 (32)")
                        .customTitle2()
                    Spacer()
                }
                Spacer()
                
                Image(systemName: "lock")
                    .foregroundColor(Color("MainColor"))
                    .frame(width: UIScreen.getWidth(17), height: UIScreen.getHeight(19))
                
                Text("방문자 로그를 잠금해제하려면")
                    .customSubhead4()
                    .foregroundColor(Color("MainColor"))
                Text("방문 인증이 필요해요")
                    .customSubhead4()
                    .foregroundColor(Color("MainColor"))
            }
            .frame(height: UIScreen.getHeight(300))
            .padding(EdgeInsets(top: UIScreen.getHeight(30), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
            
            VStack {
                Button(action: {}) {
                    HStack(spacing: 6) {
                        Image("foot")
                            .resizable()
                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
                        Text("방문 인증하기")
                            .customSubhead4()
                        .foregroundColor(Color.white)
                    }
                }
            }
            .frame(width: UIScreen.getWidth(280),height: UIScreen.getHeight(50))
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color("MainColor"), lineWidth: 2)
            )
            .background(Color("MainColor"))
        }
        .padding(.bottom, UIScreen.getHeight(40))
    }
}

struct GuestLogView_Previews: PreviewProvider {
    static var previews: some View {
        GuestLogView()
    }
}
