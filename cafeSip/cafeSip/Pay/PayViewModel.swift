//
//  PayViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//
import SwiftUI

@Observable
class PayViewModel {
    var balance = 1000
    var userName = "samepleName"
    var userId = "sampleId"
    
    init() {
        if let currentUserData = AuthManager.shared.currentUser {
            self.userName = currentUserData.userName
            self.userId = currentUserData.id
        }
    }
}
