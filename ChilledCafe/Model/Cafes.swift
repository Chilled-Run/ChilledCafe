//
//  Cafes.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/10.
//

import Foundation
struct Cafes: Codable, Hashable {
    
    let name: String
    let shortIntroduction: String
    let thumbnail: String
    let moodImages: [String]
    let cafeInfo: [String]
    let bookmark: Bool
    let ar: Bool
    let tag: [String]
    let location: String
    let businessHour: [String]
}
