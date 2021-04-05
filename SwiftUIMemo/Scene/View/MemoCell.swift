//
//  MemoCell.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/05.
//

import SwiftUI

struct MemoCell: View {
    @ObservedObject var memo: Memo
    //ObservedObject를 추가하면 메모 객체가 업데이트 될때마다 뷰가 새롭게 그려짐 그래서 항상 최신 데이터를 유지한다.
    @EnvironmentObject var formatter: DateFormatter
    //안가져오면 formatter를 사용할수없다
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.content)
                .font(.body)
                .lineLimit(1)
            
            Text("\(memo.insertDate,formatter: self.formatter)")
                //String Interpolation구문으로 변경
                .font(.caption)
                .foregroundColor(Color(UIColor.secondaryLabel))
            
        }
    }
}


struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        MemoCell(memo: Memo(content: "Test"))
            .environmentObject(DateFormatter.memoDataFormatter)
    }
}
