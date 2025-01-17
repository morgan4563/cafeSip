//
//  LoginView.swift
//  cafeSip
//
//  Created by hyunMac on 12/15/24.
//

import SwiftUI

struct LoginView: View {
    @State private var loginViewModel = LoginViewModel()
    @State private var loginNavigtionViewModel = LoginNavigationViewModel()
    
    var body: some View {
        NavigationStack(path: $loginNavigtionViewModel.navigationPath) {
            VStack() {
                Spacer()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("""
                    안녕하세요.
                    cafeSip입니다.
                    """)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    
                    Text("회원 서비스 이용을 위해 로그인 해주세요.")
                        .foregroundStyle(.black)
                        .opacity(0.6)
                        .padding(.horizontal)
                        .padding(.bottom, 12)
                    
                    TextField("이메일", text: $loginViewModel.email)
                        .autocapitalization(.none)
                        .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(.horizontal)
                    
                    SecureField("비밀번호", text: $loginViewModel.password)
                        .padding(.horizontal)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.5))
                        .padding(.horizontal)
                    
                    
                }
                
                Button("회원가입") {
                    loginNavigtionViewModel.goToSignupEmailView()
                }
                .font(.subheadline)
                .foregroundStyle(.brown)
                .padding()
                
                
                Spacer()
                
                Button {
                    Task {
                        await loginViewModel.signIn()
                    }
                } label: {
                    Text("로그인")
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.brown)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "SignupEmailView":
                    SignupEmailView(loginViewModel: $loginViewModel, loginNavigtionViewModel: $loginNavigtionViewModel)
                case "SignupPasswordView":
                    SignupPasswordView(loginViewModel: $loginViewModel, loginNavigtionViewModel: $loginNavigtionViewModel)
                case "SignupUserNameView":
                    SignupUserNameView(loginViewModel: $loginViewModel, loginNavigtionViewModel: $loginNavigtionViewModel)
                case "CompleteSignupView":
                    CompleteSignupView(loginViewModel: $loginViewModel, loginNavigtionViewModel: $loginNavigtionViewModel)
                default:
                    Text("잘못된 접근")
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
