//
//  LoginNavigtionViewModel.swift
//  cafeSip
//
//  Created by hyunMac on 1/17/25.
//
import SwiftUI

@Observable
class LoginNavigationViewModel {
    var navigationPath = NavigationPath()
    
    func goToSignupEmailView() {
        navigationPath.append("SignupEmailView")
    }
    func goToSignupPasswordView() {
        navigationPath.append("SignupPasswordView")
    }
    func goToSignupUserNameView() {
        navigationPath.append("SignupUserNameView")
    }
    func goToCompleteSignupView() {
        navigationPath.append("CompleteSignupView")
    }
    func goToLoginView() {
        navigationPath = NavigationPath()
    }
}
