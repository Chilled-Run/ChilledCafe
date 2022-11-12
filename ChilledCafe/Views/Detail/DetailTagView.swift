//
//  DetailTagView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/12.
//

import SwiftUI

struct DetailTagView: View {
    let sample: Cafes
    var body: some View {
        HStack {
            ForEach(sample.tag, id: \.self) {
                tag in
                HStack(spacing: 0) {
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
        }.padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}


//struct DetailTagView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailTagView()
//    }
//}
