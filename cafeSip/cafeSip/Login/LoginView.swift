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
            
            VStack(alignment: .leading) {
                Image("cafeSipLogo")
                    .resizable()
                    .frame(width: 60,height: 60)
                    .padding(.bottom, 10)
                
                Text("""
                안녕하세요.
                cafeSip입니다.
                """)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 8)
                
                Text("회원 서비스 이용을 위해 로그인 해주세요.")
                    .foregroundStyle(.black)
                    .opacity(0.6)
                
                TextField("이메일", text: $email)
                    .padding(.vertical, 12)
                    .autocapitalization(.none)
                
                SecureField("비밀번호", text: $password)
                    .padding(.vertical, 12)
                
            }
            .padding()
            
            Button {
                print("회원가입")
            } label: {
                Text("회원가입")
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            Button {
                print("로그인")
            } label: {
                 Text("로그인")
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
