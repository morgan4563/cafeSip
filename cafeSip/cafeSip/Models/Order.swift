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
    var menuId: UUID
    var menuName: String
    var price: String
}
