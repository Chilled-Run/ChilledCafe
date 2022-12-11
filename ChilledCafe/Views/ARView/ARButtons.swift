//
//  ARButtons.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/08.
//

import SwiftUI


// ++++++=======================================================+++++
// *
// MARK: 스토리 작성하기 ->
// 나만의 발자국을 스테핑한 후 스토리를 남기는 창으로 이동합니다.
struct startStoryButton: View {
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        Button(action: {
            self.arMainViewState = .uploadStory
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
// *
// ++++++=======================================================+++++



// ++++++=======================================================+++++
// *
// MARK: + 발자국 남기러 가기
// 다른 사람 발자국들 조회후 나만의 발자국을 남기러 이동시킵니다.
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
// *
// ++++++=======================================================+++++



// ++++++=======================================================+++++
// *
// MARK: AR 모델 선택/취소 버튼
// 로딩된 AR 모델들을 지정된 앵커에 배치하거나 취소합니다.
struct PlacementButtonsView: View {
    @Binding var arMainViewState: ARMainViewState
    @Binding var selectedModel: FootprintModel?
    @Binding var modelConfirmedForPlacement: FootprintModel?
    @Binding var isStepped: Bool
    
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
                self.isStepped = false
            }) {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .fontWeight(.medium)
                    .foregroundColor(Color.white.opacity(0.75))
            }
        }
    }
}
// *
// ++++++=======================================================+++++



// ++++++=======================================================+++++
// *
// MARK: AR창 닫기 버튼
// 초기 메인 탭뷰 화면으로 이동합니다.
struct ARCloseButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .foregroundColor(Color.white.opacity(0.8))
                .opacity(0.8)
                .frame(width: UIScreen.getWidth(40) ,height: UIScreen.getHeight(40))
        }
        
    }
}
// *
// ++++++=======================================================+++++



// ++++++=======================================================+++++
// *
// MARK: AR창 뒤로가기 버튼
// 발자국 선택 창에서 다른 사람들의 발자국을 조회하는 창으로 이동합니다.
struct ARBackButton: View {
    @Binding var arMainViewState: ARMainViewState
    var body: some View {
        Button(action: {
            self.arMainViewState = .afterFloorDetected
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .resizable()
                .foregroundColor(Color.white.opacity(0.8))
                .opacity(0.8)
                .frame(width: UIScreen.getWidth(40) ,height: UIScreen.getHeight(40))
        }
        
    }
}
// *
// ++++++=======================================================+++++



// ++++++=======================================================+++++
// *
// MARK: 클릭시 버튼이 일시적으로 커지는 애니메이션입니다.
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
// *
// ++++++=======================================================+++++
