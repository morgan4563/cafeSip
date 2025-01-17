//
//  SignupNameView.swift
//  cafeSip
//
//  Created by hyunMac on 12/16/24.
//

import SwiftUI

struct SignupUserNameView: View {
    @Binding var loginViewModel: LoginViewModel
    @Binding var loginNavigtionViewModel: LoginNavigationViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text("사용자 이름 만들기")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("앱에서 사용할 사용자 이름을 추가해주세요. 언제든지 변경할 수 있습니다.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                TextField("사용자 이름", text: $loginViewModel.userName)
                    .autocapitalization(.none)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
            }.padding()
            
            Spacer()
            
            Button("다음") {
                loginNavigtionViewModel.goToCompleteSignupView()
            }
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .frame(width: 363, height: 42)
            .background(.brown)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .tint(.black)
                }
            }
        }
    }
}

#Preview {
    SignupUserNameView(loginViewModel: .constant(LoginViewModel()), loginNavigtionViewModel: .constant(LoginNavigationViewModel()))
}
