//
//  Info.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/23.
//

import SwiftUI

struct Info: View {
    let cafe: Cafe
    var body: some View {
        VStack (alignment: .leading){
            Text("11:00에 영업 시작")
                .padding(.top, 25)
                .padding(.horizontal, 65)
            Text("매일 11:00 - 22:00")
                .padding(.horizontal, 65)
            Text("21:30 라스트 오더")
                .padding(.horizontal, 65)
            
            Text("경북 포항시 남구 형산강북로 135")
                .padding(.top, 40)
                .padding(.horizontal, 65)
            
            Image("map")
                .resizable()
                .scaledToFit()
                .padding(.top, 25)
                .padding(.horizontal)
                .frame(width: UIScreen.main.bounds.width)
            
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 500)
    }
}

//struct Info_Previews: PreviewProvider {
//    static var previews: some View {
//        Info()
//    }
//}
