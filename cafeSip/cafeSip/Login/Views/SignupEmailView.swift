//
//  SignupEmailView.swift
//  cafeSip
//
//  Created by hyunMac on 12/15/24.
//

import SwiftUI

struct SignupEmailView: View {
    @Binding var loginViewModel: LoginViewModel
    @Binding var loginNavigtionViewModel: LoginNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("이메일 주소 입력")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("회원님이 사용하실 이메일 주소를 입력해 주세요. 이 이메일 주소는 다른 사람에게 공개되지 않습니다.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                TextField("이메일 주소", text: $loginViewModel.email)
                    .autocapitalization(.none)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
            }.padding()
            
            Spacer()
            VStack {
                Text(loginViewModel.emailValidationMessage)
                    .foregroundStyle(.brown)
                
                Button("다음") {
                    if loginViewModel.email.isValidEmail() {
                        loginViewModel.setEmailValidationMessage()
                        loginNavigtionViewModel.goToSignupPasswordView()
                    } else {
                        loginViewModel.setInvalidEmailMessage()
                    }
                }
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
                    loginViewModel.setEmailValidationMessage()
                    loginViewModel.clearUserInput()
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}

//#Preview {
//    
//}
