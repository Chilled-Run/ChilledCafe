//
//  ARMainView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/11/15.
//

import SwiftUI
import FocusEntity
import RealityKit
import ARKit
import UIKit
import RealityUI

private var models: [FootprintModel] = {
    // Dynamically get file names
    let filemanager =  FileManager.default
    
    guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
        return []
    }
    
    var availableModels: [FootprintModel] = []
    for filename in files where filename.hasSuffix("usdz") {
        let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
        let model = FootprintModel(modelName: modelName)
        availableModels.append(model)
    }
    
    return availableModels
}()

let backupModel = models

struct ARMainView: View {
    @State private var isPlacementEnabled = false
    @State private var selectedModel: FootprintModel?
    @State private var isSetPosition = false
    @State private var isContinue = false
    @State private var modelConfirmedForPlacement: FootprintModel?
    @State private var stepFootprint: FootprintModel?
    @State private var isShowSheet = false
    @State private var isShowStoryButton = false
    @State private var backups = backupModel
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                
                ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement, stepFootprint: $stepFootprint, isShowSheet: $isShowSheet)
                
                if isShowSheet {
                    CreateStroyView(isPopup: $isShowSheet)
                }
                // TODO: 지금 조건문이 굉장히 많은데 이거 나중에 enum으로 리팩토링 필수!!
                if !self.isSetPosition {
                    // 초기 좌표 세팅
                    VStack{
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black)
                                .opacity(0.8)
                                .frame(width: 215, height: 40)
                        
                            Text("평평한 바닥을 인식해주세요")
                                .foregroundColor(.white)
                                .customTitle1()
                        }
                        .padding(.top, geo.safeAreaInsets.top + 30)
                        
                        Spacer()
                        
                        EmptyButtonsView(isSetPosition: $isSetPosition, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
                    }
                    .padding(.bottom, 40)
                }
                
                else {
                    if !self.isContinue {
                        // 발자국 찍기 시작하기 버튼
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.black)
                                    .opacity(0.8)
                                    .frame(width: 300, height: 60)
                                
                                Text("이 공간에 방문객들의 스토리가 담겨져 있네요! \n발자국을 눌러 확인해보세요!")
                                    .foregroundColor(.white)
                                    .customTitle1()
                            }
                            .padding(.top, geo.safeAreaInsets.top + 30)
                            
                            Spacer()
                            
                            startFootprintButton(isContinue: $isContinue)
                                .padding(.bottom, 40)
                        }
                    }
                    else {
                        if self.isPlacementEnabled && self.isSetPosition {
                            VStack{
                                ZStack {
                                    RoundedRectangle(cornerRadius: 4)
                                        .fill(Color.black)
                                        .opacity(0.8)
                                        .frame(width: 283, height: 40)
                                    
                                    Text("원하는 모양의 발바닥을 남겨주세요")
                                        .foregroundColor(.white)
                                        .customTitle1()
                                }
                                .padding(.top, geo.safeAreaInsets.top + 30)
                                
                                Spacer()
                                
                                PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$stepFootprint, isShowStoryButton: $isShowStoryButton)
                                    .padding(.bottom, 40)
                            }
                        }
                        else {
                            
                            if self.isShowStoryButton {
                                startStoryButton(isShowSheet: $isShowSheet)
                                .padding(.bottom, 40)
                                
                            }
                            else {
                                ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: models)
                                    .padding(.bottom, 40)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
}

// ARView container
struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: FootprintModel?
    @Binding var stepFootprint: FootprintModel?
    @Binding var isShowSheet: Bool
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
        
        // ---------------------------------------------------------
        RealityUI.enableGestures(.all, on: arView)
        
        return arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let anchorEntity = AnchorEntity(plane: .any)
        if let model = self.modelConfirmedForPlacement {
            if let modelEntity = model.modelEntity {
                print("DEBUG - adding model to scene: \(model.modelName)")
                let clicky = ClickyEntity(model: modelEntity.model!) {
                    (clickedObj, atPosition) in
                    // In this example we're just assigning the colour of the clickable
                    // entity model to a green SimpleMaterial.
                    print("hello hello")
                    print(anchorEntity.position)
                    
                    self.isShowSheet.toggle()
                    
                }
                anchorEntity.addChild(clicky)
                uiView.scene.addAnchor(anchorEntity)
            }
            
            var xX: Float = -0.1
            var zZ: Float = -0.1
            
            var count = 0
            _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ t in
                
                let anchorEntity2 = AnchorEntity(plane: .any)
                let model2 = backupModel[count]
                if let modelEntity2 = model2.modelEntity {
                    print("DEBUG - adding model to scene: \(model2.modelName)")
                    let clicky2 = ClickyEntity(model: modelEntity2.model!) {
                        (clickedObj, atPosition) in
                        // In this example we're just assigning the colour of the clickable
                        // entity model to a green SimpleMaterial.
                        print("hello hello")
                        print(anchorEntity.position)
                        self.isShowSheet.toggle()
                        
                    }
                    anchorEntity2.transform.translation = [xX, 0, zZ]
                    anchorEntity2.addChild(clicky2)
                    uiView.scene.addAnchor(anchorEntity2)
                }
                xX = (xX - 0.1) * -1
                zZ -= 0.2
                count += 1
                
                if count >= 4 {
                        t.invalidate()
                }
            }
            
            DispatchQueue.main.async {
                self.modelConfirmedForPlacement = nil
            }
        }
        
        if let secondModel = self.stepFootprint {
            if let secondEntity = secondModel.modelEntity {
                print("DEBUG - adding model to scene: \(secondModel.modelName)")
                let clicky = ClickyEntity(model: secondEntity.model!) {
                    (clickedObj, atPosition) in
                    // In this example we're just assigning the colour of the clickable
                    // entity model to a green SimpleMaterial.
                    print("hello hello")
                    print(anchorEntity.position)
                    
                    self.isShowSheet.toggle()
                    
                }
                anchorEntity.addChild(clicky)
                uiView.scene.addAnchor(anchorEntity)
            }
            
            DispatchQueue.main.async {
                self.stepFootprint = nil
            }
        }

    }
    
}



// Custom ARView with FocusEntity
class CustomARView: ARView {
    let focusSquare = FESquare()
    
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        
        focusSquare.viewDelegate = self
        focusSquare.delegate = self
        focusSquare.setAutoUpdate(to: true) // Auto-update position in scene
        
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

struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.white.opacity(0.8))
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct startFootprintButton: View {
    @Binding var isContinue: Bool
    var body: some View {
        Button(action: {
            self.isContinue = true
        }) {
            Text("+ 발자국 남기러 가기")
                .foregroundColor(.black)
        }
        .buttonStyle(GrowingButton())

    }
}

struct startStoryButton: View {
    @Binding var isShowSheet: Bool
    var body: some View {
        Button(action: {
            self.isShowSheet.toggle()
        }) {
            Text("스토리 남기러 가기 ->")
                .foregroundColor(.black)
        }
        .buttonStyle(GrowingButton())

    }
}

// Picker UI
struct ModelPickerView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: FootprintModel?
    
    var models: [FootprintModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(0 ..< self.models.count) {
                    index in
                    Button(action: {
                        print("DEBUG - selected model with name: \(self.models[index].modelName)")
                        self.selectedModel = self.models[index]
                        self.isPlacementEnabled = true
                    }) {
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .frame(height: 71)
                            .aspectRatio(1/1, contentMode: .fit)
                            .background(Color.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
    }
}

// Placement confirm/cancel UI
struct EmptyButtonsView: View {
    @Binding var isSetPosition: Bool
    @Binding var selectedModel: FootprintModel?
    @Binding var modelConfirmedForPlacement: FootprintModel?
    
    var body: some View {
        HStack {
            // Confirmation button
            Button(action: {
                print("DEBUG - confirm model placement")
                self.modelConfirmedForPlacement = models.last
                resetParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 50, height: 50)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
            }
        }
    }
    func resetParameters() {
        self.isSetPosition = true
        // self.selectedModel = nil
    }
}


// Placement confirm/cancel UI
struct PlacementButtonsView: View {
    @Binding var isPlacementEnabled: Bool
    @Binding var selectedModel: FootprintModel?
    @Binding var modelConfirmedForPlacement: FootprintModel?
    @Binding var isShowStoryButton: Bool
    
    var body: some View {
        HStack {
            // Cancel button
            Button(action: {
                print("DEBUG - cancel model placement")
                self.resetParameters()
            }) {
                Image(systemName: "xmark")
                    .frame(width: 50, height: 50)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            
            // Confirmation button
            Button(action: {
                print("DEBUG - confirm model placement")
                self.modelConfirmedForPlacement = self.selectedModel
                resetParameters()
            }) {
                Image(systemName: "checkmark")
                    .frame(width: 50, height: 50)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
    }
    
    func resetParameters() {
        self.isPlacementEnabled = false
        self.isShowStoryButton = true
    }
}


struct ARMainView_Previews: PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}
