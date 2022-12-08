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

enum ARMainViewState {
    case idle
    case beforeFloorDetected
    case afterFloorDetected
    case chooseFootprint
    case beforeStepFootprint
    case afterStepFootprint
    case uploadStory
    case readStory
}

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
    @State private var otherFootprintModel = models
    @State private var otherFootprintName = ""
    
    @State private var arMainViewState = ARMainViewState.beforeFloorDetected
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                
                ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement, stepFootprint: $stepFootprint, isShowSheet: $isShowSheet, otherFootprintModel: $otherFootprintModel, otherFootprintName: $otherFootprintName)
                
//                if isShowSheet {
//                    CreateStoryView(isPopup: $isShowSheet, isContinue: $isContinue)
//                }
                
                if isShowSheet {
                    StoryView(isPopup: $isShowSheet, otherFootPrintName: $otherFootprintName)
                }
                // TODO: 지금 조건문이 굉장히 많은데 이거 나중에 enum으로 리팩토링 필수!!

                // 초기 좌표 세팅
                if arMainViewState == .beforeFloorDetected {
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
                        .padding(.top, geo.safeAreaInsets.top)
                        
                        Spacer()
                        
                        EmptyButtonsView(arMainViewState: $arMainViewState, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
                    }
                    .padding(.bottom, 60)
                }
                
                if arMainViewState == .afterFloorDetected {
                    // 발자국 찍기 시작하기 버튼
                    VStack {
                        ZStack {
                            VStack(alignment: .center){
                                Text("이 공간에 방문객들의 스토리가 담겨져 있네요!")
                                    .foregroundColor(.white)
                                    .customTitle1()
                                Text("발자국을 눌러 확인해보세요!")
                                    .foregroundColor(.white)
                                    .customTitle1()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.black)
                            .opacity(0.8)
                            .cornerRadius(4)
                        }
                        .padding(.top, geo.safeAreaInsets.top)
                        
                        Spacer()
                        
                        startFootprintButton(arMainViewState: $arMainViewState)
                            .padding(.bottom, 60)
                    }
                }
                
                if arMainViewState == .chooseFootprint {
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
                        .padding(.top, geo.safeAreaInsets.top)
                        
                        Spacer()
                        ModelPickerView(arMainViewState: $arMainViewState, selectedModel: self.$selectedModel, models: models)
                    }
                }
                    
                if arMainViewState == .beforeStepFootprint {
                    PlacementButtonsView(arMainViewState: $arMainViewState, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$stepFootprint, isShowStoryButton: $isShowStoryButton)
                        .padding(.bottom, 60)
                }
                
                if arMainViewState == .afterStepFootprint{
                    startStoryButton(isShowSheet: $isShowSheet, isShowStoryButton: $isShowStoryButton)
                    .padding(.bottom, 60)
                }

//                        if self.isPlacementEnabled && self.isSetPosition {
//                            PlacementButtonsView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$stepFootprint, isShowStoryButton: $isShowStoryButton)
//                                .padding(.bottom, 60)
//
//                        }
//                        else {
//
//                            if self.isShowStoryButton {
//                                startStoryButton(isShowSheet: $isShowSheet, isShowStoryButton: $isShowStoryButton)
//                                .padding(.bottom, 60)
//
//                            }
//                            else {
//                                if !self.isShowSheet {
//                                    VStack{
//                                        ZStack {
//                                            RoundedRectangle(cornerRadius: 4)
//                                                .fill(Color.black)
//                                                .opacity(0.8)
//                                                .frame(width: 283, height: 40)
//
//                                            Text("원하는 모양의 발바닥을 남겨주세요")
//                                                .foregroundColor(.white)
//                                                .customTitle1()
//                                        }
//                                        .padding(.top, geo.safeAreaInsets.top)
//
//                                        Spacer()
//                                        ModelPickerView(isPlacementEnabled: self.$isPlacementEnabled, selectedModel: self.$selectedModel, models: models)
//                                    }
//                                }
//                            }
//                        }
                    
                
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
    @Binding var otherFootprintModel: [FootprintModel]
    @Binding var otherFootprintName: String
    
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = CustomARView(frame: .zero)
        
        RealityUI.enableGestures(.all, on: arView)
        
        return arView
    }
    
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let anchorEntity = AnchorEntity(plane: .any)
        if let model = self.modelConfirmedForPlacement {
            if let modelEntity = model.modelEntity {
                print("DEBUG11111111111 - adding model to scene: \(model.modelName)")
                let clicky = ClickyEntity(model: modelEntity.model!) {
                    (clickedObj, atPosition) in
                    // 객체를 클릭했을때 나오는 무언가 ㅇㅅㅇ

                    
                }
                anchorEntity.addChild(clicky)
                uiView.scene.addAnchor(anchorEntity)
            }
            
            var xX: Float = -0.1
            var zZ: Float = -0.1
            
            var count = 0
            _ = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){ t in
                
                let anchorEntity2 = AnchorEntity(plane: .any)
                let model2 = otherFootprintModel[count]
                if let modelEntity2 = model2.modelEntity {
                    print("DEBUG222222222 - adding model to scene: \(model2.modelName)")
                    let clicky2 = ClickyEntity(model: modelEntity2.model!) {
                        (clickedObj, atPosition) in
                        // 객체를 클릭했을때 나오는 무언가 ㅇㅅㅇ
                        self.otherFootprintName = model2.modelName
                        self.isShowSheet = true
                        
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
                print("DEBUG22222222 - adding model to scene: \(secondModel.modelName)")
                let clicky = ClickyEntity(model: secondEntity.model!) {
                    (clickedObj, atPosition) in
                    
                    // 객체를 클릭했을때 나오는 무언가 ㅇㅅㅇ
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
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(.white.opacity(0.8))
            .foregroundColor(.black)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.2 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct startFootprintButton: View {
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        Button(action: {
            self.arMainViewState = .chooseFootprint
        }) {
            HStack(alignment: .center) {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                Text("발자국 남기러 가기")
                    .customTitle2()
                    .foregroundColor(.black)
            }
        }
        .buttonStyle(GrowingButton())

    }
}

struct startStoryButton: View {
    @Binding var isShowSheet: Bool
    @Binding var isShowStoryButton: Bool
    var body: some View {
        Button(action: {
            self.isShowSheet = true
            self.isShowStoryButton = false
        }) {
            HStack (alignment: .center) {
                Text("스토리 남기러 가기")
                    .customTitle2()
                    .foregroundColor(.black)
                Image(systemName: "arrow.forward")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
        }
        .buttonStyle(GrowingButton())

    }
}

// Picker UI
struct ModelPickerView: View {
    @Binding var arMainViewState: ARMainViewState
    @Binding var selectedModel: FootprintModel?
    
    var models: [FootprintModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(0 ..< self.models.count - 1) {
                    index in
                    Button(action: {
                        print("DEBUG - selected model with name: \(self.models[index].modelName)")
                        self.selectedModel = self.models[index]
                        self.arMainViewState = .beforeStepFootprint
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
        .padding(.bottom, 40)
        .background(Color.white.opacity(0.6))
    }
}

// Placement confirm/cancel UI
struct EmptyButtonsView: View {
    @Binding var arMainViewState: ARMainViewState
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
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.75))
            }
        }
    }
    
    func resetParameters() {
        self.arMainViewState = .afterFloorDetected
        // self.selectedModel = nil
    }
}


// Placement confirm/cancel UI
struct PlacementButtonsView: View {
    @Binding var arMainViewState: ARMainViewState
    @Binding var selectedModel: FootprintModel?
    @Binding var modelConfirmedForPlacement: FootprintModel?
    @Binding var isShowStoryButton: Bool
    
    var body: some View {
        HStack(spacing: 30) {
            // Cancel button
            Button(action: {
                print("DEBUG - cancel model placement")
                self.arMainViewState = .chooseFootprint
            }) {
                Image(systemName: "xmark.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.75))
            }
            
            // Confirmation button
            Button(action: {
                print("DEBUG - confirm model placement")
                self.modelConfirmedForPlacement = self.selectedModel
                self.arMainViewState = .afterStepFootprint
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.75))
            }
        }
    }
    
//    func resetParameters() {
//        self.arMainViewState = .beforeStepFootprint
////        self.isPlacementEnabled = false
////        self.isShowStoryButton = true
//    }
}


struct ARMainView_Previews: PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}
