//
//  IntroView.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/27.
//
import SwiftUI

struct IntroView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Image("OnboardingBackground")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    NavigationLink(destination: MainView(), label: {
                        CustomConfirmButtonView(title: "Let's go!")
                    })
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(60), trailing: 0))
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color("MainColor"))
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
