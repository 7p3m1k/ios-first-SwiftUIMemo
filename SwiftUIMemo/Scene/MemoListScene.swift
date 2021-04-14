//
//  MemoListScene.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/02.
//

import SwiftUI
import Alamofire

struct MemoListScence: View {
    @EnvironmentObject var store: MemoStore
    //EnvironmentObject 모든 뷰가 읽을 수 있는 shared 데이터
    @EnvironmentObject var formatter: DateFormatter
    //formatter 속성 추가
    @State var showComposer: Bool = false
    //showComposer 제어할때 사용
    
    
    //api 작업중
    struct Welcome: Codable {
        let name, note: String
        let photoURL: String
        let tags: [String]
        let sns: [String]

        enum CodingKeys: String, CodingKey {
            case name, note
            case photoURL = "photo_url"
            case tags, sns
        }
    }

    
    let request = AF.request("https://us-central1-allius.cloudfunctions.net/getUserBasicInfo?nickname=david").responseJSON() { response in
      switch response.result {
      case .success:
        if let data = try! response.result.get() as? [String: Any] {
          print(data)
        }
      case .failure(let error):
        print("Error: \(error)")
        return
      }
    }
    //api 작업중 여기까지
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(store.list) { memo in
                    NavigationLink(
                        destination: DetailScene(memo: memo),
                        label: {
                            MemoCell(memo: memo)
                        })
                }
                .onDelete(perform: store.delete) //MomoStore.swfit에서 만들었던 딜리트 매소드를 파라미터로 전달
            }
            .navigationBarTitle("내 메모")
            .navigationBarItems(trailing: ModalButton(show: $showComposer))
            .sheet(isPresented: $showComposer, content: {
                ComposeScene(showComposer: self.$showComposer)
//                    .environmentObject(KeyboardObserver())
                    .environmentObject(self.store) //insert 크러쉬나면 써야한다는데 오류가 안뜸.. 일단 주석
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
