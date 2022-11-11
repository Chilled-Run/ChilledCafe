//
//  FullCardListView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/11/11.
//

import SwiftUI

struct FullCardScrollView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ForEach(0..<30) { _ in
                NavigationLink(destination: {
                    EmptyView()
                }, label: {
                    FullCardView(imageURL: "")
                })
            }
        }
    }
}

struct FullCardScrollView_Previews: PreviewProvider {
    static var previews: some View {
        FullCardScrollView()
    }
}
