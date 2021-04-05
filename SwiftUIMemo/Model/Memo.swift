//
//  Memo.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/02.
//

import SwiftUI

class Memo: Identifiable, ObservedObject {
    //Identifiable : 데이터 목록을 테이블뷰,컬렉션뷰에 쉽게 바인딩 가능
    //ObservedObject : 반응형 UI 를 위하여

    let id : UUID  // Identifiable  프로토콜이 요구하는 속성, 메모를 유일하게 구분할때 사용

    @Published var content: String
    //메모 내용을 저장
    //Published 특성을 추가하면 새로운 값이 저장될때마다 바인딩 되어있는 ui가 자동으로 업데이트
    
    let insertDate : Date
    //메모를 생성한 날짜 저장
    
    init(id: UUID = UUID(), content:String, insertDate: Date = Date()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
    } //앞에서 만든 3가지 속성을 초기화 하는 생성자
}

extension Memo : Equatable {
    static func == (lhs: Memo, rhs:Memo) -> Bool {
        return lhs.id == rhs.id
    }
}




