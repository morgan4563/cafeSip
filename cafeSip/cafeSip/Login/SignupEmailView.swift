//
//  SignupEmailView.swift
//  cafeSip
//
//  Created by hyunMac on 12/15/24.
//

import SwiftUI

struct SignupEmailView: View {
    @Environment(\.dismiss) var dismiss
    @State var email = ""
    
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
                TextField("이메일 주소", text: $email)
                    .autocapitalization(.none)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.gray.opacity(0.5))
            }.padding()
            
            Spacer()
            
            Button {
                print("다음")
            } label: {
                Text("다음")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
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
    SignupEmailView()
}
