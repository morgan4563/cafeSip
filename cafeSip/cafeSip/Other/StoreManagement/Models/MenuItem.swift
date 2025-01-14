//
//  menuItem.swift
//  cafeSip
//
//  Created by hyunMac on 1/14/25.
//
import SwiftUI

struct MenuItem: Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var price: String
}
