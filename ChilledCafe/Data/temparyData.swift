//
//  temparyData.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//
import Foundation
struct constant{
    
    let sample = Cafe(name: "꾸꾸하우스", shortIntroduction: "에스프레소 맛에 진심인 카페", thumbnail: "OnboardingImage1", moodImages: ["https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F11.jpg?alt=media&token=ad6aaf6d-e13a-4d2c-b290-f7475a7d2b8b", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313", "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F11.jpg?alt=media&token=ad6aaf6d-e13a-4d2c-b290-f7475a7d2b8b",
                                                                                                                            "https://firebasestorage.googleapis.com/v0/b/chilledcafe-1cc36.appspot.com/o/Cafe%2F%EC%98%81%EC%9D%BC%EB%8C%80%2F%EC%95%84%EB%9D%BC%EB%B9%84%EC%B9%B4%EC%BB%A4%ED%94%BC%EB%A1%9C%EC%8A%A4%ED%84%B0%EC%8A%A4%2F1.jpg?alt=media&token=b9a5422a-8b3e-4eec-a350-c4dcc9364313",], cafeInfo: ["테라스에 앉아 바다를 배경으로 그림 그리기","낮에는 커피를 팔고 밤에는 술을 파는 곳","AR 컨텐츠르로 다양한 공간 스토리를 볼 수 있는 곳"], bookmark: true, ar: true, tag: ["바다와 함께","바다와 함께","AR 경험"], location: "포항시 남구 지곡로 82", businessHour: [""])
    
    //-------------------------------
    
    var storyId: String = UUID().uuidString
    var userName: String = ""
    var visitCount: Int = 1
    var content: String = ""
    var image: String = ""
    var likeCount: Int = 0
    var creatAt: Date = Date()

    
    let post = Post(storyId: "1" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1)
    
    let posts: [Post] = [Post(storyId: "1" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1),Post(storyId: "2" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1),Post(storyId: "3" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1),Post(storyId: "4" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1),Post(storyId: "5" ,userName: "손님이 왕", visitCount: 1, content: "너무 행복해요?", image: "bearPaw", likeCount: 1)]
    
    let comment = Comment3(storyId: "1", userName: "나도 왕", content: "굿굿")
    
    let comments: [Comment3] = [Comment3(storyId: "1", userName: "나도 왕", content: "굿굿"), Comment3(storyId: "1", userName: "나도 왕", content: "굿굿"), Comment3(storyId: "1", userName: "나도 왕", content: "굿굿"), Comment3(storyId: "1", userName: "나도 왕", content: "굿굿"), Comment3(storyId: "1", userName: "나도 왕", content: "굿굿"), Comment3(storyId: "1", userName: "나도 왕", content: "굿굿")]
    
    }
