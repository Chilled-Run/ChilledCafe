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
    // 동적으로 파일명을 가져옵니다.
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

// ARMainView 내 각각의 상태값들
enum ARMainViewState {
    case idle
    case checkingLocation
    case accessGranted
    case accessDenied
    case beforeFloorDetected
    case afterFloorDetected
    case chooseFootprint
    case beforeStepFootprint
    case afterStepFootprint
    case uploadStory
    case readStory
}

struct ARMainView: View {
    @State private var selectedModel: FootprintModel?
    @State private var modelConfirmedForPlacement: FootprintModel?
    @State private var stepFootprint: FootprintModel?
    @State private var otherFootprintModel = models
    @State private var otherFootprintName = ""
    
    // @State private var arMainViewState = ARMainViewState.beforeFloorDetected
    @State private var arMainViewState = ARMainViewState.idle
    @StateObject var checkCurrentLocationViewModel = CheckCurrentLocationViewModel()
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                if arMainViewState == .idle {
                    Color.black.ignoresSafeArea()
                        .opacity(0.8)
                        .navigationBarHidden(true)
                        .onAppear {
                        checkCurrentLocationViewModel.requestPermission()
                    }
                }
                
                if checkCurrentLocationViewModel.authorizationStatus == .authorizedWhenInUse || checkCurrentLocationViewModel.authorizationStatus == .authorizedAlways {
                    ARViewContainer(modelConfirmedForPlacement: self.$modelConfirmedForPlacement, stepFootprint: $stepFootprint, arMainViewState: $arMainViewState, otherFootprintModel: $otherFootprintModel, otherFootprintName: $otherFootprintName)
                        .onAppear {
                            arMainViewState = .checkingLocation
                        }
                }
            
                    
    
                Group {
                    if arMainViewState == .checkingLocation {
                        CheckCurrentLocationView(arMainViewState: $arMainViewState)
                            .environmentObject(checkCurrentLocationViewModel)
                    }
                    
                    Group {
                        if arMainViewState == .accessGranted {
                            AccessGrantedView(arMainViewState: $arMainViewState)
                                .onAppear {
                                    HapticManager.instance.notification(type: .success)
                                }
                        }
                    }
                    if arMainViewState == .accessDenied {
                        AccessDeniedView(arMainViewState: $arMainViewState)
                            .onAppear {
                                HapticManager.instance.notification(type: .error)
                            }
                    }
                }
                
                if arMainViewState == .readStory {
                    StoryView(arMainViewState: $arMainViewState, otherFootPrintName: $otherFootprintName)
                }
                
                if arMainViewState == .uploadStory {
                    CreateStoryView(arMainViewState: $arMainViewState)
                }

                // 초기 바닥 좌표 세팅
                // ARMainViewState :: .beforeFloorDetected
                if arMainViewState == .beforeFloorDetected {
                    VStack{
                        HStack {
                            ARCloseButton(arMainViewState: $arMainViewState)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black)
                                .opacity(0.8)
                                .frame(width: 215, height: 40)
                            
                            Text("평평한 바닥을 인식해주세요")
                                .foregroundColor(.white)
                                .customTitle1()
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        EmptyButtonsView(arMainViewState: $arMainViewState, selectedModel: $selectedModel, modelConfirmedForPlacement: $modelConfirmedForPlacement)
                    }
                    .padding(.top, geo.safeAreaInsets.top + 17)
                    .padding(.bottom, 60)
                }
                
                // 바닥 좌표 세팅 완료 후 순차적으로 다른 사람들 발바닥 조회
                // ARMainViewState :: .afterFloorDetected
                if arMainViewState == .afterFloorDetected {
                    VStack {
                        HStack {
                            ARCloseButton(arMainViewState: $arMainViewState)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        
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
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        startFootprintButton(arMainViewState: $arMainViewState)
                    }
                    .padding(.top, geo.safeAreaInsets.top + 17)
                    .padding(.bottom, 60)
                }
                
                // MARK: 발자국 선택창
                // ARMainViewState :: .chooseFootrint
                if arMainViewState == .chooseFootprint {
                    VStack {
                        HStack {
                            ARBackButton(arMainViewState: $arMainViewState)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        ZStack {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.black)
                                .opacity(0.8)
                                .frame(width: 283, height: 40)
                            
                            Text("원하는 모양의 발바닥을 남겨주세요")
                                .foregroundColor(.white)
                                .customTitle1()
                        }
                        .padding(.top, 30)
                        
                        Spacer()
                        
                        ModelPickerView(arMainViewState: $arMainViewState, selectedModel: self.$selectedModel, models: models)
                    }
                    .padding(.top, geo.safeAreaInsets.top + 17)
                }
                
                // MARK: 발자국 선택 후 스테핑할 위치 선정
                // ARMainViewState :: .beforeStepFootprint
                if arMainViewState == .beforeStepFootprint {
                    PlacementButtonsView(arMainViewState: $arMainViewState, selectedModel: self.$selectedModel, modelConfirmedForPlacement: self.$stepFootprint)
                        .padding(.bottom, 60)
                }
                
                // MARK: 발자국 스테핑 후 스토리 작성 선택 창
                // ARMainViewState :: .afterStepFootprint
                if arMainViewState == .afterStepFootprint{
                    VStack {
                        HStack {
                            ARCloseButton(arMainViewState: $arMainViewState)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        
                        Spacer()
                        
                        startStoryButton(arMainViewState: $arMainViewState)
                            .padding(.bottom, 60)
                    }
                    .padding(.top, geo.safeAreaInsets.top + 17)
                    .padding(.bottom, 60)
                }
            }
            .ignoresSafeArea()
            .navigationBarBackButtonHidden(true)
        }
    }
}

// ARView container
struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedForPlacement: FootprintModel?
    @Binding var stepFootprint: FootprintModel?
    @Binding var arMainViewState: ARMainViewState
    @Binding var otherFootprintModel: [FootprintModel]
    @Binding var otherFootprintName: String
    
    func makeUIView(context: Context) -> ARView {
        weak var arView = CustomARView(frame: .zero)
        
        arView!.renderOptions = [.disableMotionBlur,
                                        .disableDepthOfField,
                                        .disablePersonOcclusion,
                                        .disableGroundingShadows,
                                        .disableFaceMesh,
                                        .disableHDR]
        
        RealityUI.enableGestures(.all, on: arView!)
        
        return arView!
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
                        self.arMainViewState = .readStory
                        
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
                print("DEBUG333333 - adding model to scene: \(secondModel.modelName)")
                let clicky = ClickyEntity(model: secondEntity.model!) {
                    (clickedObj, atPosition) in
                    
                    // 객체를 클릭했을때 나오는 무언가 ㅇㅅㅇ
                    print("hello hello")
                    print(anchorEntity.position)
                    
                    self.arMainViewState = .uploadStory
                    
                }
                anchorEntity.addChild(clicky)
                uiView.scene.addAnchor(anchorEntity)
            }
            
            DispatchQueue.main.async {
                self.stepFootprint = nil
            }
        }

    }
    
    func dismantleUIView(_ uiView: ARView, coordinator: ()) {
        uiView.session.pause()
        uiView.session.delegate = nil
        uiView.scene.anchors.removeAll()
        uiView.removeFromSuperview()
        uiView.window?.resignKey()
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
    }
}


struct ARMainView_Previews: PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}

