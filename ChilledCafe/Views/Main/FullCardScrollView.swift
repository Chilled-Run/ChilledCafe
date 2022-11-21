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
            ForEach(firebaseSM.cafeList[firebaseSM.selectedCategory] ?? [], id: \.self) { cafe in
                NavigationLink(destination: {
                    BODetailView(cafe: cafe)
                }, label: {
                    FullCardView(firebaseSM: firebaseSM, cafe: cafe)
                })
            }
            Spacer(minLength: UIScreen.getHeight(30))
        }
    }
}

//struct FullCardScrollView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullCardScrollView()
//    }
//}
