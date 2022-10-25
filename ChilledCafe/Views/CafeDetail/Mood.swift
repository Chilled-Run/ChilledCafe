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
    var columnGrid: [GridItem] = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1)]
    
    let cafe: Cafe
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            LazyVGrid(columns: columnGrid,  alignment: .center, spacing: 1) {
                ForEach ((0...22), id: \..self) {
                    KFImage(URL(string: cafe.moodImages[$0 % cafe.moodImages.count]))
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 2.2 - 1)
                    
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 150)
        }
        
    }
}

