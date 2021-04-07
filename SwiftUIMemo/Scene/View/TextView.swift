//
//  TextView.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/07.
//

import UIKit
import SwiftUI

struct TextView: UIViewRepresentable {
    @Binding var text: String //바인딩 속성 추가
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {
        let myTextView = UITextView()
        myTextView.delegate = context.coordinator
        
        return myTextView
    }
    
    func updateUIView(_ uiView:UITextView, context:Context) {
        uiView.text = text
    }
    
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextView
        
        init(_ uiTextView: TextView){
            self.parent = uiTextView
        }
        
        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }
        
    }
}
