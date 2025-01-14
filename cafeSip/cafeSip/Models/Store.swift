//
//  Store.swift
//  cafeSip
//
//  Created by hyunMac on 1/13/25.
//

struct Store: Codable {
    let id: String
    var name: String
    let address: String
    let detailAddress: String
    var menuItems: [MenuItem]?
}
