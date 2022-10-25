//
//  SelectAtmosphereView2.swift
//  ChilledCafe
//
//  Created by Terry Koo on 2022/10/25.
//

import SwiftUI

struct SelectAtmosphereView: View {
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var checked = Array(1...14).map{ _ in false }
    var images = Array(1...14).map{ "OnboardingImage\($0)" }
    
    init() {
        print("SelectAtmosphereView 뷰 초기화")
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack{
                    HStack {
                        Image("AppNameImage")
                            .resizable()
                            .frame(width: UIScreen.getWidth(150), height: UIScreen.getHeight(32))
                        Spacer()
                    }
                    .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: 0, bottom: UIScreen.getHeight(10), trailing: 0))
                    HStack {
                        Text("선호하는 분위기를 선택해주세요?")
                            .customSubhead4()
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: UIScreen.getHeight(40), trailing: 0))
                    
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(Array(images.enumerated()), id: \.1) { index, image in
                                Button(action: {
                                    self.checked[index].toggle()
                                }, label: {
                                    Image(image)
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(4)
                                        .overlay(content: {
                                            ZStack {
                                                if checked[index] == true {
                                                    RoundedRectangle(cornerRadius: 4)
                                                        .fill(Color(uiColor: .black))
                                                        .opacity(0.6)
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.white)
                                                        .font(.system(size: 36))
                                                } else {
                                                    Text("BABO")
                                                        .hidden()
                                                }
                                            }
                                        })
                                })
                            }
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
                VStack {
                    Spacer()
                    if checked.filter { $0 == true }.isEmpty == false {
                        NavigationLink(destination: MainCategoryView().environmentObject(FirebaseStorageManager()), label: {
                            Image("ReadyButton")
                                .resizable()
                                .frame(width: UIScreen.getWidth(140), height: UIScreen.getHeight(50))
                        })
                    }
                }
            }
        }
    }
}



struct SelectAtmosphereView2_Previews: PreviewProvider {
    static var previews: some View {
        SelectAtmosphereView()
    }
}
