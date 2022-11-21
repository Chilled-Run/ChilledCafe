//
//  User.swift
//  ChilledCafe
//
//  Created by 종건 on 2022/11/18.
//

import Foundation

struct User: Codable, Hashable {
    let uuid: String
    var cafe: [String]
}
