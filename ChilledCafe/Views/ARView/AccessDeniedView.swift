//
//  AccessDeniedView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/09.
//

import SwiftUI

struct AccessDeniedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
                .opacity(0.8)
                .navigationBarHidden(true)
            
            VStack {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .foregroundColor(Color.orange)
                Text("공간에 위치하지 않은것 같아요")
                    .customTitle2()
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                    .foregroundColor(Color("MainColor"))
                Button(action: {
                    self.arMainViewState = .checkingLocation
                }) {
                    Text("방문 확인 다시 시도")
                        .customSubhead4()
                        .padding(EdgeInsets(top: 16, leading: 73, bottom: 16, trailing: 73))
                        .foregroundColor(.white)
                        .background(Color("MainColor"))
                }
                
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("다음에 방문")
                        .customSubhead4()
                        .padding(EdgeInsets(top: 16, leading: 73, bottom: 16, trailing: 73))
                        .foregroundColor(Color("MainColor"))
                }
                
            }
            .padding(.top, 20)
            .background(Color.white.opacity(0.7))
            .cornerRadius(4)
            
        }
    }
}

