//
//  ARModel.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/06.
//

import UIKit
import RealityKit
import Combine
import RealityUI

class FootprintModel {
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?

    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String) {
        self.modelName = modelName
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                // 에러 핸들
                print("DEBUG - unable to load model entity for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // 모델 엔티티 가져오기
                self.modelEntity = modelEntity

                print("DEBUG - successfully loaded model eneity for modelName: \(self.modelName)")
            })
    }
}


class ClickyEntity: Entity, HasClick, HasModel {
  var tapAction: ((HasClick, SIMD3<Float>?) -> Void)?

    init(model: ModelComponent, tapAction: @escaping ((HasClick, SIMD3<Float>?) -> Void)) {
    self.tapAction = tapAction
    super.init()
    self.model = model
    self.generateCollisionShapes(recursive: false)
  }

  required convenience init() {
     self.init()
  }
}
