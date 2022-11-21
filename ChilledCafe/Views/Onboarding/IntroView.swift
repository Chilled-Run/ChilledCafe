//
//  IntroView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/27.
//
import SwiftUI

struct IntroView: View {
    @AppStorage("isFirst") var isFirst: Bool = true
    
    var body: some View {
            ZStack {
                Image("OnboardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    Button(action: {
                        isFirst = false
                    }, label: {
                        CustomConfirmButtonView(title: "Let's go!")
                    })
                    
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(60), trailing: 0))
            }
            .navigationBarHidden(true)
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
