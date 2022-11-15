//
//  ARMainView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/11/15.
//

import SwiftUI

struct ARMainView: View {
    var body: some View {
        ZStack{
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
            
            Image("ARGuide")
                .resizable()
                .scaledToFit()
                
        }
        .ignoresSafeArea(.all)
    }
}


struct ARMainView_Previews: PreviewProvider {
    static var previews: some View {
        ARMainView()
    }
}
