//
//  FullCardListView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/11.
//

import SwiftUI

struct FullCardScrollView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            // 카드뷰 처음 보일때 여백
            Spacer(minLength: UIScreen.getHeight(20))
            ForEach(firebaseSM.cafeList[firebaseSM.selectedCategory] ?? [], id: \.self) { cafe in
                NavigationLink(destination: {
                    BODetailView(cafe: cafe, firebaseSM: firebaseSM)
                        .navigationBarHidden(true)
                }, label: {
                    FullCardView(firebaseSM: firebaseSM, cafe: cafe)
                })
            }
            Spacer(minLength: UIScreen.getHeight(30))
        }
        .padding(0)
    }
}

//struct FullCardScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCardScrollView()
//    }
//}
