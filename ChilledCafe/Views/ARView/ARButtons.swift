//
//  ARButtons.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/08.
//

import SwiftUI

struct ARButtons: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ARBackButton: View {
    @Binding var arMainState: ARMainViewState
    var body: some View {
        Button(action: {
            if arMainState == .beforeFloorDetected {
                
            }
            else if arMainState == .afterFloorDetected {
                
            }
            else if arMainState == .chooseFootprint {
                
            }
            else if arMainState == .beforeStepFootprint {
                
            }
            else if arMainState == .afterStepFootprint {
                
            }
            else {
                
            }
        }) {
            Image(systemName: "chevron.left.circle.fill")
                .resizable()
                .foregroundColor(Color.gray)
                .opacity(0.8)
                .frame(width: UIScreen.getWidth(40) ,height: UIScreen.getHeight(40))
                .shadow(radius:8 ,x: 0, y: 0)
        }
        
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

struct ARButtons_Previews: PreviewProvider {
    static var previews: some View {
        ARButtons()
    }
}
