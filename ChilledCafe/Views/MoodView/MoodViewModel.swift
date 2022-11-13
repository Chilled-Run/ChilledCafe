//
//  MoodViewModel.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/11/12.
//

import SwiftUI

class MoodViewModel: ObservableObject {
    
    // 이미지 뷰어를 위한 프로퍼티들
    @Published var showImageViewer = false
    
    @Published var selectedImageID: String = ""
    
    @Published var imageViewerOffset: CGSize = .zero
    
    // 배경 Opacity
    @Published var bgOpacity: Double = 1
    
    // 확대를 위한 이미지 스케일링
    @Published var imageScale: CGFloat = 1
    
    func onChange(value: CGSize) {
        
        // offset 업데이트
        imageViewerOffset = value
        
        // offset 계산
        let halgHeight = UIScreen.screenHeight / 2
        let progress = imageViewerOffset.height / halgHeight
        
        withAnimation(.default) {
            bgOpacity = Double(1 - (progress < 0 ? -progress : progress))
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeInOut) {
            var translation = value.translation.height
            
            if translation < 0 {
                translation = -translation
            }
            
            if translation < 200 {
                imageViewerOffset = .zero
                bgOpacity = 1
            }
            else {
                showImageViewer.toggle()
                imageViewerOffset = .zero
                bgOpacity = 1
            }
        }
    }
}
