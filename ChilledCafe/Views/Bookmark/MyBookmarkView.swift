//
//  MyBookmarkView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/13.
//

import SwiftUI

struct MyBookmarkView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    init(firebaseSM: FirebaseStorageManager){
        self.firebaseSM = firebaseSM
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(red: 0.16, green: 0.29, blue: 0.57, alpha: 1.00)]
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(Array(zip(firebaseSM.bookmarkedCafeList.indices, firebaseSM.bookmarkedCafeList)), id: \.1) { index, cafe in
                NavigationLink(destination: {
                    BODetailView(firebaseSM: firebaseSM, index: index)
                }, label: {
                    FullCardView(firebaseSM: firebaseSM, index: index)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .navigationBarTitle("내가 갈 카페")
        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: 0, bottom: 0, trailing: 0))
    }
    
    // MARK: 뒤로가기 버튼
    var backButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color("MainColor"))
            }
        }
    }
}

//struct MyBookmarkView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyBookmarkView()
//    }
//}
