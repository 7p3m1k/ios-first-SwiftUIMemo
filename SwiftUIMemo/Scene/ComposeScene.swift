//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/05.
//

import SwiftUI


struct ComposeScene: View {
    //키보드옵저버를 주입할 속성을 선언
//    @EnvironmentObject var Keyboard: KeyboardObserver
    //memo 스토어 속성 선언
    @EnvironmentObject var store: MemoStore
    //입력한 텍스트를 바인딩 할때 쓰는 속성 (주로 state 특성으로 선언)
    @State private var content: String = ""
    
    @Binding var showComposer: Bool //바인딩 속성 선언
    
    var memo: Memo? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                TextView(text: $content)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    .padding(.bottom,Keyboard.context.height)
//                    .animation(.easeInOut(duration: Keyboard.context.animatioDuration))
                    .background(Color.blue) //텍스트 필드 어딨는지 확인 할려고 백그라운드 색상줌
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) //infinity : 사용가능한 최대크기
            .navigationBarTitle(memo != nil ? "메모 편집" : "새 메모", displayMode:  .inline)
            .navigationBarItems(
                leading: DismissButton(show: $showComposer),
                trailing: SaveButton(show: $showComposer, content: $content, memo: memo))
        }
        //onAppear 모디파이어 추가
        //화면이 표시되는 시점에 초기화 되는 코드를 구현할때 쓰임
        .onAppear {
            self.content = self.memo?.content ?? ""
        }
    }
}

fileprivate struct DismissButton: View {
    
    @Binding var show: Bool
    
    var body: some View {
        Button(action: {
            self.show = false
        }, label: {
            Text("취소")
        })
    }
}

fileprivate struct SaveButton: View {
    
    @Binding var show: Bool
    
    @EnvironmentObject var store: MemoStore
    @Binding var content: String //입력한 텍스트는 바인딩으로 받음
    
    var memo: Memo? = nil
    
    var body: some View {
        Button(action: {
            
            if let memo = self.memo { //메모가 전달 됐으면 편집모드니까 업데이트 메소드
                self.store.update(memo: memo, content: self.content)
            } else {
                //insert코드
                self.store.insert(memo: self.content)
            }
            
            self.show = false
        }, label: {
            Text("저장")
        })
    }
}


struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene(showComposer: .constant(false))
            .environmentObject(MemoStore())
        //MemoStore를 커스텀 공유 데이터로 등록
//            .environmentObject(KeyboardObserver())
    }
}
