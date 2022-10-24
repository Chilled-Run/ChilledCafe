//
//  Mood.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/10/23.
//

import SwiftUI
import Kingfisher
import Firebase

struct Mood: View {
    // var images: [String] = ["cuphat", "donute", "roaster", "rooftop", "sand", "view", "inside"]
    
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
    
    let cafe: Cafe
    
    var body: some View {
//        GeometryReader{ geo in
            ScrollView(.vertical, showsIndicators: false){
                LazyVGrid(columns: columnGrid,  alignment: .center, spacing: 1) {
                    ForEach ((0...22), id: \..self) {
                        KFImage(URL(string: cafe.moodImages[$0 % cafe.moodImages.count]))
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 2.4 - 1)
                        
                    }
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 150)
            }
//        }
//        .padding(.vertical, 300)
    }
}
//
//struct Mood_Previews: PreviewProvider {
//    @EnvironmentObject var firebaseStorageManager: FirebaseStorageManager
//
//    static var previews: some View {
//        Mood(cafe: firebaseStorageManager.cafeClassification["내 취향에 맞는 카페"]![0]))
//    }
//}
