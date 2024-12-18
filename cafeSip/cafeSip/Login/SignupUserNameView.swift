//
//  SignupNameView.swift
//  cafeSip
//
//  Created by hyunMac on 12/16/24.
//

import SwiftUI

struct SignupUserNameView: View {
    @Environment(\.dismiss) var dismiss
    @State var name = ""
    
    var body: some View {
        VStack {
            Text("비밀번호 만들기")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("다른 사람이 추측할 수 없는 6자 이상의 문자 또는 숫자로 비밀번호를 만드세요.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            VStack {
                SecureField("비밀번호", text: $name)
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
    SignupUserNameView()
}

