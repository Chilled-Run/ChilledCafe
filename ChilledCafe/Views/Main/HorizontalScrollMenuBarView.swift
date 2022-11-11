//
//  HorizontalScrollMenuBarView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/10.
//

import SwiftUI

struct HorizontalScrollMenuBarView: View {
    @State var choosed: Int = 0
    @ObservedObject var firebaseSM: FirebaseStorageManager
    var category: [String]
    
    init(category: [String], firebaseSM: FirebaseStorageManager) {
        self.firebaseSM = firebaseSM
        self.category = category
        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .bottom , spacing: 0) {
                    // MARK: - 여백
                    VStack {
                        Circle()
                            .frame(width:UIScreen.getWidth(20), height: 1)
                            .hidden()
                        Rectangle()
                            .frame(width: UIScreen.getWidth(20) ,height: UIScreen.getHeight(2))
                            .foregroundColor(Color("CustomGray3"))
                    }
                    // MARK: - 카테고리
                    ForEach(Array(category.enumerated()), id: \.0) { index, item in
                        VStack {
                            CategoryButtonView(imageName: "Bada", title: "\(item)")
                                .foregroundColor(index == choosed ? Color("MainColor") : Color("CustomGray2"))
                                .id(index)
                                .onTapGesture {
                                    choosed = index
                                    firebaseSM.selectedCategory = item
                                    withAnimation { proxy.scrollTo(index, anchor: UnitPoint.center) }
                                }
                            Rectangle()
                                .frame(width: UIScreen.getWidth(88) ,height: UIScreen.getHeight(2))
                                .foregroundColor(index == choosed ? Color("MainColor") : Color("CustomGray3"))
                        }
                        
                    }
                    // MARK: - 여백
                    VStack {
                        Circle()
                            .frame(width:UIScreen.getWidth(20), height: 1)
                            .hidden()
                        Rectangle()
                            .frame(width: UIScreen.getWidth(20) ,height: UIScreen.getHeight(2))
                            .foregroundColor(Color("CustomGray3"))
                    }
                }
            }
        }
    }
}

//struct HorizontalScrollMenuBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalScrollMenuBarView()
//    }
//}
