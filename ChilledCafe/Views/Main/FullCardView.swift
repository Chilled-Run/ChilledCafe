//
//  FullCardView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/11.
//

import SwiftUI

struct FullCardView: View {
    let imageURL: String
    
    var body: some View {
        Image("FullCard")
            .resizable()
            .frame(width: UIScreen.getWidth(350), height: UIScreen.getHeight(250))
    }  
}

struct FullCardView_Previews: PreviewProvider {
    static var previews: some View {
        FullCardView(imageURL: "")
    }
}
