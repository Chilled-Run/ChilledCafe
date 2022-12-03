//
//  GuestPost.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import Foundation

struct GuestPost {
    let postId: String
    let userName: String
    let visitCount: Int
    let context: String
    let image: String
    var like: Bool
    let likeCount: Int
    let time: String
    let comments: [Comment]
}

struct Comment {
    let userName: String
    let context: String
}
