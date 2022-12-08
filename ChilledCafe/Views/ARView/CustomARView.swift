//
//  CustomARView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/09.
//

import Foundation
import FocusEntity
import ARKit
import RealityKit

// Custom ARView with FocusEntity
class CustomARView: ARView {
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true) // Scene내에서 자동 업데이트
        
        self.setupARView()
    }
    
    
    @objc required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupARView() {
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        config.environmentTexturing = .automatic
        
        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }
        
        self.session.run(config)
    }
}

extension CustomARView: FEDelegate {
    func toTrackingState() {
        print("Tracking FE")
    }
    func toInitializingState() {
        print("Tnitializing FE")
    }
}
