//
//  TextView.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/09.
//

//textfield 커스텀
import SwiftUI
//textfield custom
struct TextView: UIViewRepresentable {
    var placeholder: String
    var textColor: Color
    @Binding var text: String

    var minHeight: CGFloat
    @Binding var calculatedHeight: CGFloat
    
    init(placeholder: String, textColor:Color ,text: Binding<String>, minHeight: CGFloat, calculatedHeight: Binding<CGFloat>) {
        self.placeholder = placeholder
        self.textColor = textColor
        self._text = text
        self.minHeight = minHeight
        self._calculatedHeight = calculatedHeight
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.delegate = context.coordinator

        // Decrease priority of content resistance, so content would not push external layout set in SwiftUI
        textView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        textView.isScrollEnabled = false
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = true
        textView.showsHorizontalScrollIndicator = false
        textView.font = UIFont(name:"AppleSDGothicNeo-Medium" , size: 16)
        // Set the placeholder
        textView.text = placeholder
        textView.textColor = UIColor(textColor)
      
        return textView
    }

    func updateUIView(_ textView: UITextView, context: Context) {
        textView.text = self.text
        recalculateHeight(view: textView)
    }

    func recalculateHeight(view: UIView) {
       
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if minHeight < newSize.height && $calculatedHeight.wrappedValue != newSize.height {
            if newSize.height < 60 {
                DispatchQueue.main.async {
                    self.$calculatedHeight.wrappedValue = newSize.height // !! must be called asynchronously
                }
            }
        } else if minHeight >= newSize.height && $calculatedHeight.wrappedValue != minHeight {
            DispatchQueue.main.async {
                self.$calculatedHeight.wrappedValue = self.minHeight // !! must be called asynchronously
            }
        }
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            // This is needed for multistage text input (eg. Chinese, Japanese)
            if textView.markedTextRange == nil {
                parent.text = textView.text ?? String()
                parent.recalculateHeight(view: textView)
            }
        }
        
        //플레이스홀더 이후 글자색
//        func textViewDidBeginEditing(_ textView: UITextView) {
//            if textView.textColor == UIColor.lightGray {
//                textView.text = nil
//                textView.textColor = UIColor(self.textColor)
//            }
//        }

        //플래이스 홀더
//        func textViewDidEndEditing(_ textView: UITextView) {
//            if textView.text.isEmpty {
//                textView.text = parent.placeholder
//                textView.textColor = UIColor.lightGray
//            }
//        }
    }
}
