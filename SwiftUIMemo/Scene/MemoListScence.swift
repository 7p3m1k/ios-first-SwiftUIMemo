//
//  ContentView.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/02.
//

import SwiftUI

struct MemoListScence: View {
    @EnvironmentObject var store: MemoStore
    //EnvironmentObject 모든 뷰가 읽을 수 있는 shared 데이터
    @EnvironmentObject var formatter: DateFormatter
    //formatter 속성 추가
    @State var showComposer: Bool = false
    //showComposer 제어할때 사용
    
    var body: some View {
        NavigationView {
            List(store.list) { memo in
                MemoCell(memo: memo)
            }
            .navigationBarTitle("내 메모")
            .navigationBarItems(trailing: ModalButton(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                ComposeScene(showComposer: self.$showComposer)
            })
        }
    }
}

fileprivate struct ModalButton: View {
    @Binding var show: Bool
    
    var body: some View {
        Button(action:{
            self.show = true
        },label: {
            Image(systemName: "plus")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListScence()
            .environmentObject(MemoStore())
        //프리뷰에서 사용할 메모스토어를 커스텀 공유데이터로 등록
            .environmentObject(DateFormatter.memoDataFormatter)
    }
}

