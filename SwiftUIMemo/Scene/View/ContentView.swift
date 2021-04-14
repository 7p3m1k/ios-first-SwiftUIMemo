//
//  contentView.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/13.
//

import SwiftUI
struct ContentView: View {
    
    @State var users: [User] = []
    
    var body: some View {
        Text("dd")
            .onAppear{
                apiCall().getUsers { (users) in
                    self.users = users
                }
            }
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
