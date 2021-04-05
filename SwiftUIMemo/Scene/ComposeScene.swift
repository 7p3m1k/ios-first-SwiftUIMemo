//
//  ComposeScene.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/05.
//

import SwiftUI

struct ComposeScene: View {
    //memo 스토어 속성 선언
    @EnvironmentObject var store: MemoStore
    //입력한 텍스트를 바인딩 할때 쓰는 속성 (주로 state 특성으로 선언)
    @State private var content: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("", text: $content) //출력전용 (입력을 받을수x)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) //infinity : 사용가능한 최대크기
            .navigationBarTitle("새 메모", displayMode:  .inline)
            .navigationBarItems(leading: DismissButton(), trailing: SaveButton())
        }
    }
}

fileprivate struct DismissButton: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("취소")
        })
    }
}

fileprivate struct SaveButton: View {
    var body: some View {
        Button(action: {
            
        }, label: {
            Text("저장")
        })
    }
}


struct ComposeScene_Previews: PreviewProvider {
    static var previews: some View {
        ComposeScene()
            .environmentObject(MemoStore())
        //MemoStore를 커스텀 공유 데이터로 등록
    }
}
