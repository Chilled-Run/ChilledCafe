//
//  DetailTagView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/13.
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
                    spacing: 6,
                    alignment: .leading
                ) {
                    item in
                    HStack(spacing: 0) {
                        
                        //테그에 아이콘 삭제
//                        Image("\(Icon(rawValue: item) ?? .ocean)")
//                            .resizable()
//                            .frame(width: UIScreen.getWidth(20), height: UIScreen.getHeight(20))
//                            .padding(.leading, 10)
//                            .foregroundColor(Color("MainColor"))
//
                        Text(item)
                            .customSubhead1()
                            .foregroundColor(Color("MainColor"))
                            .padding(.leading, 10)
                            .padding(.trailing, 10)
                    }
                    .frame(height: UIScreen.getHeight(22))
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color("MainColor"), lineWidth: 1)
                    )
                }
                Spacer()
            }
        }
        .padding(EdgeInsets(top: UIScreen.getHeight(20), leading: UIScreen.getWidth(20), bottom: 0, trailing: UIScreen.getWidth(20)))
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


