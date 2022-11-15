//
//  SampleCardView.swift
//  ARExperience
//
//  Created by Kyubo Shim on 2022/11/09.
//

import SwiftUI

struct SampleCardView: View {
    @State private var textToShow = "5번째 방명록"
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .opacity(0.8)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                Text("5번째 방명록")
                    .foregroundColor(Color("MainColor"))
                    .bold()
                    .font(.system(size: 40))
                Text("사장이 제일 아끼는 잔..\n하지만 손놈 3명이 깨고 갔다지...")
                    .font(.system(size: 30))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct SampleCardView_Previews: PreviewProvider {
    static var previews: some View {
        SampleCardView()
    }
}
