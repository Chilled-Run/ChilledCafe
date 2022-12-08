//
//  ARButtons.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/08.
//

import SwiftUI

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
}

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
//struct ARButtons_Previews: PreviewProvider {
//    static var previews: some View {
//        ARButtons()
//    }
//}
