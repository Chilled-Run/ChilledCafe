//
//  AcessGrantedView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/09.
//

import SwiftUI

struct AccessGrantedView: View {
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
                .opacity(0.8)
                .navigationBarHidden(true)
            VStack(alignment: .center) {
                LottieView(filename: "welcoming")
                    .frame(width: 200, height: 200)
                Text("이 공간에 여러분의 스토리를 담아")
                    .foregroundColor(.white)
                    .customSubhead4()
                Text("발자국을 남겨보세요.")
                    .foregroundColor(.white)
                    .customSubhead4()
                
                Button(action: {
                    self.arMainViewState = .beforeFloorDetected
                }) {
                    Text("발자국 남기러 가기")
                        .customSubhead4()
                        .padding(EdgeInsets(top: 10, leading: 91, bottom: 10, trailing: 91))
                        .foregroundColor(.white)
                        .background(Color("MainColor"))
                        .cornerRadius(4)
                    
                }
                .padding(.top, 30)
            }
        }

    }
}
