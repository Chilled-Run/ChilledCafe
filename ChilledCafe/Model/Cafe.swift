//
//  Cafe.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/22.
//

import Foundation
struct Cafe: Codable, Hashable {
    
    let name: String
    let city: String
    let spot: String
    let shortIntroduction: String
    let thumbnail: String
    let moodImages: [String]
    let menuImages: [String]
    let cafeInfo: [String]
    let tag: String
    let gif: String
}

