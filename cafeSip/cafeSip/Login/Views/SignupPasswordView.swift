//
//  SignupPasswordView.swift
//  cafeSip
//
//  Created by hyunMac on 12/16/24.
//

import SwiftUI

struct SignupPasswordView: View {
    @Binding var loginViewModel: LoginViewModel
    @Binding var loginNavigtionViewModel: LoginNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("비밀번호 만들기")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요 최소 하나 이상의 숫자와 영문자가 포함되어야 합니다. ")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                SecureField("비밀번호", text: $loginViewModel.password)
                    .autocapitalization(.none)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
            }.padding()
            
            Spacer()
            VStack {
                Text(loginViewModel.passwordValidationMessage)
                    .foregroundStyle(.brown)
                
                Button("다음") {
                    if loginViewModel.password.isValidPassword() {
                        loginViewModel.setPasswordValidationMessage()
                        loginNavigtionViewModel.goToSignupUserNameView()
                    } else {
                        loginViewModel.setInvalidPasswordMessage()
                    }
                }
                .fontWeight(.semibold)
                .foregroundStyle(.white)
                .frame(width: 363, height: 42)
                .background(.brown)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .fontWeight(.semibold)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                    loginViewModel.setPasswordValidationMessage()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    SignupPasswordView(loginViewModel: .constant(LoginViewModel()), loginNavigtionViewModel: .constant(LoginNavigationViewModel()))
}
