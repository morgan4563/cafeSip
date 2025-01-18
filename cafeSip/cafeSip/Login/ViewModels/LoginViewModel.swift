//
//  LoginViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import SwiftUI

@Observable
class LoginViewModel {
    var email = ""
    var password = ""
    var userName = ""
    
    func signIn() async {
        await AuthManager.shared.signIn(email: email, password: password)
        
        if let storeId = AuthManager.shared.currentUser?.storeId {
            await StoreManager.shared.loadCurrentStoreData(storeId: storeId)
        }
        
    }
    
    func createUser() async {
        await AuthManager.shared.createUser(email: email, password: password, userName: userName)
        self.email = ""
        self.password = ""
        self.userName = ""
    }
}
