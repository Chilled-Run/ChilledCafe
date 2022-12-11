//
//  UploadCompleteView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/11.
//

import SwiftUI

struct UploadCompleteView: View {
    @State var isShow = false
    @Binding var arMainViewState: ARMainViewState
    @State var finish = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
                .opacity(0.8)
                .navigationBarHidden(true)
            
            EmitterView()
                .scaleEffect(isShow ? 1 : 0, anchor: .top)
                .opacity(isShow && !finish ? 1 : 0)
                .ignoresSafeArea()
                .onAppear{
                    doAnimation()
                }
            
            VStack(alignment: .center) {
                Image("Congrats")
                    .resizable()
                    .frame(width: 190, height: 170)
                Text("이 공간에 내 발자취를 남겼어요!")
                    .foregroundColor(.white)
                    .customSubhead4()
                Text("다른 공간 스토리도 둘러보세요.")
                    .foregroundColor(.white)
                    .customSubhead4()
                
                Button(action: {
                    self.arMainViewState = .afterFloorDetected
                }) {
                    Text("발자국 남기러 가기")
                        .customSubhead4()
                        .padding(EdgeInsets(top: 10, leading: 91, bottom: 10, trailing: 91))
                        .foregroundColor(.white)
                        .background(Color("MainColor"))
                        .cornerRadius(4)
                    
                }
                .padding(.top, 30)
            }
        }
    }
    
    func doAnimation() {
        withAnimation(.spring()) {
            isShow = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 1.5)) {
                finish = true
            }
        }
    }
}

struct EmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .clear
        
        let emitterLayer = CAEmitterLayer()
        emitterLayer.emitterShape = .line
        emitterLayer.emitterCells = createEmitterCells()
        
        emitterLayer.emitterSize = CGSize(width: UIScreen.screenWidth, height: 1)
        emitterLayer.emitterPosition = CGPoint(x: UIScreen.screenWidth / 2, y: 0)
        
        view.layer.addSublayer(emitterLayer)
        
        return view
    }
    
    func createEmitterCells() -> [CAEmitterCell]{
        var emitterCells: [CAEmitterCell] = []
        
        for index in 1 ... 4 {
            let cell = CAEmitterCell()
            cell.contents = UIImage(named: getImage(index: index))?.cgImage
            cell.color = UIColor.white.cgColor
            cell.birthRate = 2.5
            cell.lifetime = 5
            cell.velocity = 200
            cell.scale = 0.05
            cell.spin = 3.5
            cell.spinRange = 1
            
            cell.emissionLongitude = .pi
            cell.emissionRange = 0.5
            
            cell.yAcceleration = 40
            
            emitterCells.append(cell)
        }
        return emitterCells
    }
    
    func getImage(index: Int) -> String {
        if index < 2 {
            return "particle1"
        }
        else if index >= 2  && index < 3 {
            return "particle2"
        }
        else if index >= 3 && index < 4{
            return "particle3"
        }
        else {
            return "particle4"
        }
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
}

