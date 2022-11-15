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
            ForEach(Array(zip(firebaseSM.cafeListClassification[firebaseSM.selectedCategory]?.indices ?? [].indices, firebaseSM.cafeListClassification[firebaseSM.selectedCategory] ?? [])), id: \.1) { index, cafe in
                NavigationLink(destination: {
                    BODetailView(firebaseSM: firebaseSM, index: index)
                }, label: {
                    FullCardView(firebaseSM: firebaseSM, index: index)
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
