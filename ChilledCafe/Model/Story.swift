//
//  GuestPost.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/12/02.
//

import Foundation
import SwiftUI

struct Story {
    let storyId: UUID
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
    let commentId: UUID
    let userName: String
    let context: String
}

//서버 연결
//현재 개인을 고유로 구별하는 방법이 없어서 like는 고려x

struct Post {
    var storyId: String = UUID().uuidString
    var userName: String = ""
    var visitCount: Int = 1
    var content: String = ""
    var image: String = ""
    var likeCount: Int = 0
    var creatAt: String = dateToString()

    // For easy upload to firebase
    var dictionary: [String: Any] {
        return [
            "storyId": storyId,
            "userName": userName,
            "visitCount": visitCount,
            "content": content,
            "image": image,
            "likeCount": likeCount,
            "creatAt": creatAt
        ]
    }
}

struct Comment3 {
    
    
    var commentId: String = UUID().uuidString
    var storyId: String = ""
    var userName: String = ""
    var content: String = ""
    var creatAt: String = dateToString()

    // For easy upload to firebase
    var dictionary: [String: Any] {
        return [
            "commentId": commentId,
            "storyId": storyId,
            "userName": userName,
            "content": content,
            "creatAt": creatAt
        ]
    }
}


struct Story2: Codable, Hashable {
    let storyId: UUID
    let userName: String
    let visitCount: Int
    let content: String
    let image: String
   //var like: Bool
    //
    let likeCount: Int
  //  let time: String
    let creatAt: String
}

struct Comment2: Codable, Hashable {
    let commentId: UUID
    let storyId: UUID
    let userName: String
    let context: String
    let creatAt: Date
}


//

func dateToString()-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy.MM.dd"
    return dateFormatter.string(from: Date())
}
