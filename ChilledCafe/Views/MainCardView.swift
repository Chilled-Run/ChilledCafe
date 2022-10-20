//
//  MainCardView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//

import SwiftUI

struct MainCardView: View {
    let hotPlace: HotPlace
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .frame(width: 20, height: 20)
            Image("\(hotPlace.imageURL)")
                .resizable()
                 .aspectRatio(contentMode: .fill)
            VStack(){
                Spacer()
                Text(hotPlace.city).foregroundColor(Color.black)
                Text(hotPlace.spot).foregroundColor(Color.black)
                
            }
        }
    }
}

//struct MainCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainCardView()
//    }
//}
