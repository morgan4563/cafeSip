//
//  LoginView.swift
//  cafeSip
//
//  Created by hyunMac on 12/15/24.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack() {
            Spacer()
            
            VStack(alignment: .leading, spacing: 12) {
                Image("cafeSipLogo")
                    .resizable()
                    .frame(width: 60,height: 60)
                
                Text("""
                안녕하세요.
                cafeSip입니다.
                """)
                .font(.title)
                .fontWeight(.semibold)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .foregroundStyle(.black)
                    .opacity(0.6)
                    .padding(.bottom, 12)
                
                TextField("이메일", text: $email)
                    .autocapitalization(.none)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                
                SecureField("비밀번호", text: $password)
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
                    
                
            }
            .padding()
            
            Button {
                print("회원가입")
            } label: {
                Text("회원가입")
                    .font(.subheadline)
                    .foregroundStyle(.brown)
            }
            
            Spacer()
            
            Button {
                print("로그인")
            } label: {
                 Text("로그인")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}

#Preview {
    LoginView()
}
