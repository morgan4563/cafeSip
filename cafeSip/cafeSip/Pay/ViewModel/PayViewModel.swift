//
//  PayViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//
import SwiftUI
import FirebaseFirestore

@Observable
class PayViewModel {
    var payModel = PayModel()
    var isLoading = false
    
    var balance: Int {
        get { payModel.getBalance() }
        set { payModel.setBalance(newBalance: newValue) }
    }
    
    var userId: String {
        get { payModel.getUserId() }
        set { payModel.setUserId(id: newValue) }
    }

    func loadUser() {
        if let currentUser = AuthManager.shared.currentUser {
            isLoading = true
            self.balance = currentUser.balance
            self.userId = currentUser.id
        }
    }
    
    func chargePaymoney(amount: Int) async -> Bool {
        guard await getBalance() else { return false }
        balance += amount
        updateBalance()
        return true
    }
    
    func updateBalance() {
        Firestore.firestore().collection("users").document(userId).updateData(
            ["balance" : balance]
        )
    }
    
    func getBalance() async -> Bool {
        do {
            let user = try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            self.balance = user.balance
        } catch {
            print("balanceData 수신 실패")
            return false
        }
        return true
    }
}
