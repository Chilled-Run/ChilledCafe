//
//  AlertView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/09.
//

import SwiftUI

struct AlertView: View {
    
    @Binding var isShown: Bool
    @State var text = "Initial Text"
    let screenSize = UIScreen.main.bounds
    let title = "타이틀"
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .opacity(0.8)
                .navigationBarHidden(true)
            
            VStack {
                Text("이 스토리를 삭제하시겠어요?")
                    .font(.headline)
                Text("뒤로가면 이 글은 복구가 불가합니다.")
                    .font(.footnote)
                HStack {
                    Button("아니오") {
                        isShown.toggle()
                    }
                    Button("삭제") {
                        isShown.toggle()
                    }
                }
            }
            .frame(width: UIScreen.getWidth(270), height: UIScreen.getHeight(136))
            .overlay(RoundedRectangle(cornerRadius: 14)
                .stroke(Color.gray, lineWidth: 4))
            .background(Color.gray)
            
        }
        .padding(.top, 0)
            .offset(y: isShown ? 0 : screenSize.height)
    }
}
