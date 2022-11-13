//
//  MyBookmarkView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/13.
//

import SwiftUI

struct MyBookmarkView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    
    init(firebaseSM: FirebaseStorageManager){
        self.firebaseSM = firebaseSM
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.16, green: 0.29, blue: 0.57, alpha: 1.00)]
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(firebaseSM.bookmarkedCafeList, id: \.self) { cafe in
                NavigationLink(destination: {
                    BODetailView(cafe: cafe)
                }, label: {
                    FullCardView(cafe: cafe)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle("내가 갈 카페")
        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: 0, bottom: 0, trailing: 0))
    }
}

//struct MyBookmarkView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyBookmarkView()
//    }
//}
