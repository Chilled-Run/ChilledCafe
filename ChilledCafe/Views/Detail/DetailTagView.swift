//
//  DetailTagView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/12.
//

import SwiftUI

struct DetailTagView: View {
    let sample: Cafes
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                // 한 줄의 길이보다 테그들의 길이가 길면 다음줄로 넘겨줌
                FlexibleView(
                    availableWidth: UIScreen.getWidth(350), data: sample.tag,
                    spacing: 10,
                    alignment: .leading
                ) {
                    item in
                    HStack(spacing: 0) {
                        Image("바다와 함께")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.white)
                            .frame(width: UIScreen.getWidth(24), height: UIScreen.getHeight(24))
                            .padding(.leading, 10)
                        
                        Text(item)
                            .customSubhead3()
                            .foregroundColor(Color.white)
                            .padding(.leading, 6)
                            .padding(.trailing, 10)
                    }
                    .frame(height: UIScreen.getHeight(31))
                    .background(Color("MainColor"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color("MainColor"), lineWidth: 2)
                    )
                }
                Spacer()
            }
        }.padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
    }
}


struct DetailTagView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTagView(sample: constant().sample)
    }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    // 한 줄의 길이
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State var elementsSize: [Data.Element: CGSize] = [:]
    
    var body : some View {
        VStack(alignment: alignment, spacing: spacing) {
            
            ForEach(computeRows(), id: \.self) { rowElements in
                
                HStack(spacing: spacing) {
                    
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                            .fixedSize()
                            .readSize { size in
                                elementsSize[element] = size
                            }
                    }
                }
            }
        }
    }
    // MARK: 줄 계산
    func computeRows() -> [[Data.Element]] {
        
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        // element와 한 줄의 남은 길이 비교
        for element in data {
            
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
           
            if remainingWidth - (elementSize.width + spacing) >= 0 {
                rows[currentRow].append(element)
            }
            else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth = remainingWidth - (elementSize.width + spacing)
            print("Debuging second",remainingWidth)
        }
        
        return rows
    }
}

// MARK: 각 아이템의 넓이 계산
extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}
