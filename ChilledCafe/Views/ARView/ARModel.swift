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
                // Handle error
                print("DEBUG - unable to load model entity for modelName: \(self.modelName)")
            }, receiveValue: { modelEntity in
                // Get model entity
                self.modelEntity = modelEntity

                print("DEBUG - successfully loaded model eneity for modelName: \(self.modelName)")
            })
    }
}


/// Example class that uses the HasClick protocol
class ClickyEntity: Entity, HasClick, HasModel {
  // Required property from HasClick
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

