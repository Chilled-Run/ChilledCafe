//
//  Info.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/23.
//

import SwiftUI

struct Info: View {
    var body: some View {
        VStack (alignment: .leading){
            HStack{
                Image(systemName: "clock.fill")
                    .padding(.leading, 20)
                    .foregroundColor(Color("MainColor"))
                    .padding(.bottom, 37)
                VStack(alignment: .leading) {
                    Text("11:00에 영업 시작")
                        .customBody()

                    Text("매일 11:00 - 22:00")
                        .customBody()
                    Text("21:30 라스트 오더")
                        .customBody()

                }
                .padding(.leading, 25)
            }
            .padding(.top, 80)
            
            HStack{
                Image("locationIcon")
                    .foregroundColor(.black)
                    .padding(.leading, 20)
                
                Text("경북 포항시 남구 형산강북로 135")
                    .customBody()
                    .padding(.leading, 25)
            }
            .padding(.top, 40)
            
            Image("map")
                .resizable()
                .scaledToFit()
                .padding(.top, 25)
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
