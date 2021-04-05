//
//  DateFormatter+Memo.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/05.
//

import Foundation


extension DateFormatter { //memoDataFormatter에 타입 프로퍼티 추가
    static let memoDataFormatter: DateFormatter = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        f.locale = Locale(identifier: "Ko_kr")
        return f
    }()
}


//DateFormatter 클레스에 ObservableObject 프로토콜 구현
extension DateFormatter: ObservableObject { //선언만 추가했음
    
}
