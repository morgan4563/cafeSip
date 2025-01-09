//
//  AuthManager.swift
//  cafeSip
//
//  Created by hyunMac on 1/9/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    static let shared = AuthManager()
    var currentAuthUser: FirebaseAuth.User?
    
    func createUser(email: String, password: String, userName: String) async {
        print(email,password,userName)
        
        do {
            // firebase에 아이디생성
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            
            // 해당 아이디에 데이터 넣기 아이디도 생성해서 넣어주자
            currentAuthUser = result.user
            guard let userId = currentAuthUser?.uid else { return }
            
            await uploadUserData(userId: userId, email: email, userName: userName)
        } catch {
            print("Failed to create user")
        }
    }
    
    func uploadUserData(userId: String, email: String, userName: String) async {
        let user = User(id: userId, email: email, userName: userName)
        
        do {
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("user").document(user.id).setData(encodedUser)
        } catch {
            print("Failed to upload user data")
        }
    }
}
