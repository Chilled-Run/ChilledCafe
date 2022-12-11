//
//  AllStoryView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/11.
//

import SwiftUI

struct AllStoryView: View {
    @ObservedObject var firebaseSM: FirebaseStorageManager
    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    var body: some View {
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(firebaseSM.post, id: \.self.storyId) { index in
                    StorySmallView(firebaseSM: firebaseSM, storyId: index.storyId, story: index, storyForegroundColor: getForegroundColor(foot: index.image), storyBackgroundColor: getBackgroundColor(foot: index.image))
                        }
                    }
        }
        .ignoresSafeArea(.all)
    }
}

