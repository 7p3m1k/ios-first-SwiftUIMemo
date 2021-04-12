//
//  MemoStore.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/05.
//

import Foundation
// 메모 목록을 저장하는 클래스 구현

class MemoStore: ObservableObject {
    @Published var list: [Memo]
    //Published 특성으로하면 배열을 업데이트 될떄마다 바인딩 되어있는 뷰도 함께 업데이트가 된다
    
    init() { //생성자를 만들고 더미데이터 추가
        list = [
            Memo(content: "더미 1"),
            Memo(content: "더미 2"),
            Memo(content: "더미 3")
        ]
    }
    
    //입력한 메모를 파라미터로 받은다음 리스트에 저장
    func insert(memo: String) {
        list.insert(Memo(content: memo), at:0)
        //새로운 메모는 항상 0번째에 추가 그러면 제일 위에 표시됨
    }
    //업데이트 메소드
    func update(memo:Memo?, content:String) {
        guard let memo = memo else { return }
        //guard 문은 뭔가를 검사하여 그 다음에 오는 코드들을 실행할지 말지 결정하는것, guard 문에 주어진 조건문이 거짓일 때, 여기에 달려 있는 코드블럭이 실행. guard는 반드시 else구문이 있어야함
        memo.content = content
    }
    
    func delete(memo: Memo) {
        DispatchQueue.main.async { //삭제시 콘솔에 오류 안나오게 하는 방법 이라는데 콘솔 오류가 뭔지 모르겠다. 일단은 없어도됨
            self.list.removeAll{ $0 == memo }
        }
        
    }
    
    func delete(set: IndexSet) {
        for index in set {
            self.list.remove(at: index)
        }
    }
}
