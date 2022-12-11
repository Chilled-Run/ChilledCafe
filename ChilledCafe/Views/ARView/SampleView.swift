//
//  SampleCardView.swift
//  ARExperience
//
//  Created by Kyubo Shim on 2022/11/09.
//

import SwiftUI
import UIKit

struct SampleView: View {
    @Binding var selectedModel: FootprintModel?
    @Binding var backupModel: [FootprintModel]
    var body: some View {
        Text(selectedModel?.modelName ?? "null")
    }
}

//struct SampleView_Previews: PreviewProvider {
//    static var previews: some View {
//        ARMainView()
//    }
//}
