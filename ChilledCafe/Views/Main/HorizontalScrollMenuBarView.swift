//
//  HorizontalScrollMenuBarView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct HorizontalScrollMenuBarView: View {
    @State var choosed: Int = 0
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    Circle()
                        .frame(width:20, height: 1)
                        .hidden()
                    ForEach(0..<200) { index in
                        VStack {
                            CategoryButtonView(imageName: "Bada", title: "\(index)")
                                .foregroundColor(index == choosed ? Color("MainColor") : Color("CustomGray2"))
                                .id(index)
                                .onTapGesture {
                                    choosed = index
                                    print(index)
                                    withAnimation { proxy.scrollTo(index, anchor: UnitPoint.center) }
                                }
                            Rectangle()
                                .frame(width: UIScreen.getWidth(88) ,height: UIScreen.getHeight(2))
                                .foregroundColor(index == choosed ? Color("MainColor") : Color("CustomGray2"))
                        }
                        
                    }
                }
            }
        }
    }
}

struct HorizontalScrollMenuBarView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalScrollMenuBarView()
    }
}
