//
//  Order.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import FirebaseFirestore

struct Order: Identifiable, Codable {
    var id : String
    var storeId : String
    var customerId : String
    var customerName: String
    var orderTime: Date
    var status: String
    var menuName: String
    var price: String
}

struct Store: Codable {
    let id: String
    let ownerId: String
    var name: String
    let address: String
    let detailAddress: String
    var menuItems: [MenuItem]?
}

struct User: Codable {
    let id: String
    let email: String
    var userName: String
    var balance: Int
    var storeId: String?
}

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    var name: String
    var description: String
    var price: String
}


