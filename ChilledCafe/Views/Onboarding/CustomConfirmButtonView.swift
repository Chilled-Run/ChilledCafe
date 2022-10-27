//
//  CustomConfirmButtonView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/27.
//

import SwiftUI

struct CustomConfirmButtonView: View {
    var title: String

       var body: some View {
           RoundedRectangle(cornerRadius: 24.5)
               .fill(Color("MainColor"))
               .shadow(radius: 4, x: 0, y: 4)
               .frame(width: UIScreen.getWidth(140), height: UIScreen.getHeight(50))
               .overlay(content: {
                   Text(title)
                       .CustomDesignedTitle()
                       .foregroundColor(.white)
               })
       }
}

struct CustomConfirmButtonView_Previews: PreviewProvider {
    static var previews: some View {
        CustomConfirmButtonView(title: "next")
    }
}
