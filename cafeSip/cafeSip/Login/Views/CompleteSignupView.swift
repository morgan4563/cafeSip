//
//  CompleteSingupView.swift
//  cafeSip
//
//  Created by hyunMac on 12/20/24.
//

import SwiftUI

struct CompleteSignupView: View {
    @Binding var loginViewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("아이디 생성완료.")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("\(loginViewModel.userName)님 로그인 페이지로 돌아가서 로그인을 진행해주세요.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            
            Spacer()
            
            Button {
                loginViewModel.goToLoginView()
            } label: {
                Text("완료")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
        .navigationBarBackButtonHidden()
    }
}

//#Preview {
//    CompleteSignupView(userName: .constant("닉네임"))
//}
