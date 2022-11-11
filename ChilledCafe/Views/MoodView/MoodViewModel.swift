//
//  MoodViewModel.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/11/12.
//

import SwiftUI

class MoodViewModel: ObservableObject {
    @Published var showImageViewer = false
    
    @Published var selectedImageID: String = ""
    
    @Published var imageViewerOffset: CGSize = .zero
    
    @Published var bgOpacity: Double = 1
    
    @Published var imageScale: CGFloat = 1
    
    func onChange(value: CGSize) {
        imageViewerOffset = value
        
        let halgHeight = UIScreen.main.bounds.height / 2
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
            
            if translation < 10 {
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
