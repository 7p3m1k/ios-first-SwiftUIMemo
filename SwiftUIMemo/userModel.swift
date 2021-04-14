//
//  userModel.swift
//  SwiftUIMemo
//
//  Created by 박민규 on 2021/04/13.
//

import SwiftUI

struct User: Codable, Identifiable {
    let id = UUID()
    let username: String
    let name: String
}
