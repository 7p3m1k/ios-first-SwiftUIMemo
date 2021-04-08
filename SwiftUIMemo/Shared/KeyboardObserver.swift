////
////  KeyboardObserver.swift
////  SwiftUIMemo
////
////  Created by 박민규 on 2021/04/08.
////
////
//import UIKit
//import Combine
//
//class KeyboardObserver: ObservableObject {
//    
//    //애니메이션 시간과 키보드 높이를 정하는 구조체 선언
//    struct Context {
//        let animatioDuration: TimeInterval //애니메이션 시간
//        let height: CGFloat //키보드 높이
//
//        //키보드가 숨겨진 상태의 기본값을 타입 프로퍼티로 저장
//        static let hide = Self(animatioDuration: 0.25, height: 0)
//    }
//    
//    //바인딩에 사용하는 속성
//    @Published var context = Context.hide //값이 업데이트 되면 연관되어있는 뷰도 같이 업데이트가됨
//    
//    //메모리 관리에 사용되는 속성
//    private var cancellables = Set<AnyCancellable>()
//    
//    init(){
//        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
//        
//        willShow.merge(with: willHide)
//            .compactMap(parse)
//            .assign(to: \.context, on: self)  // 변환된 context인스턴스를 context에 바인딩
//            .store(in: &cancellables)//메모리 처리에 필요한코드
//    }
//
//    func parse(notification: Notification) -> Context? {
//        guard let userInfo = notification.userInfo else { return nil }
//        
//        let safeAreaInsets = UIApplication.shared.windows.first?.safeAreaInsets
//        let animationDuration = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber)?.doubleValue ?? 0.25
//        
//        var height: CGFloat = 0
//        
//        if let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let frame = value.cgRectValue
//            
//            if frame.origin.y < UIScreen.main.bounds.height {
//                height = frame.height - (safeAreaInsets?.bottom ?? 0)
//            }
//        }
//        
//        return Context(animatioDuration: animationDuration, height: height)
//    }
//}
