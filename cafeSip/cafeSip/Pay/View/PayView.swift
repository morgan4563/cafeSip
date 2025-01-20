//
//  PayView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct PayView: View {
    @State var payViewModel = PayViewModel()
    var body: some View {
        VStack {
            if payViewModel.isLoading {
                Text("잔액 : \(payViewModel.balance)")
                    .font(.headline)
            } else {
                ProgressView("잔액 로드중")
            }
            
            Button {
                Task {
                    if await payViewModel.chargePaymoney(amount: 1000) {
                        print("정상 충전됨")
                    } else {
                        print("충전실패 에러")
                    }
                }
            } label: {
                Text("충전 1000원")
                    .padding()
                    .foregroundStyle(.white)
                    .background(.brown)
                    .cornerRadius(10)
            }
        }.onAppear {
            Task {
                payViewModel.loadUser()
                payViewModel.isLoading = await payViewModel.getBalance()
            }
        }
    }
}


#Preview {
    PayView()
}
