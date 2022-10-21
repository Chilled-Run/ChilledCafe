//
//  HotPlace.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/10/20.
//
import Foundation

struct HotPlace: Codable, Hashable {
    
    let city: String
    let spot: String
    let imageURL: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
            case city = "city"
            case spot = "spot"
            case imageURL = "imageURL"
            case description = "description"
           // case name, job, devices
        }
}


