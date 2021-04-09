//
//  DetailScene.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/08.
//

import SwiftUI

struct DetailScene: View {
    //이전화면에서 전달한 메모를 저장하는 속성 선언
    @ObservedObject var memo: Memo //속성을ObservedObject 로 선언하면 Published로 선언된 속성이 바뀔때마다 뷰를 자동으로 업데이트 해준다
    
    //메모 스토어를 주입할 속성 선언
    @EnvironmentObject var store: MemoStore
    //날짜 출력에 필요한 formatter를 주입할 속성 선언
    @EnvironmentObject var formatter: DateFormatter
    
    @State private var showEditSheet = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack {
                        Text(self.memo.content)
                            .padding()
                        Spacer()
                    }
                    
                    Text("\(self.memo.insertDate, formatter: formatter)")
                        .padding()
                        .font(.footnote)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
            }
            
            HStack {
                Button(action: {
                    //모달로 작업할꺼라 boolean 속성필요 위에 showEditSheet로 선언함
                    self.showEditSheet.toggle()
                }, label: {
                    Image(systemName: "square.and.pencil")
                })
                .padding()
                .sheet(isPresented: $showEditSheet, content: {
                    ComposeScene(showComposer: self.$showEditSheet, memo: self.memo)
                        .environmentObject(self.store)
//                        .environmentObject(KeyboardObserver())
                })
            }
            
        }
        .navigationBarTitle("메모보기")
    }
}

struct DetailScene_Previews: PreviewProvider {
    static var previews: some View {
        DetailScene(memo:Memo(content: "Swift  UI")) //에러가 발생하지 않도록 더미 메모 전달
            
            //프리뷰에서 사용할 커스텀 공유데이터
            .environmentObject(MemoStore())
            .environmentObject(DateFormatter.memoDataFormatter)
    }
}
