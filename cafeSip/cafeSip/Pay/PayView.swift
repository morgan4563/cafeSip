//
//  PayView.swift
//  cafeSip
//
//  Created by hyunMac on 1/16/25.
//

import SwiftUI

struct PayView: View {
    @State var viewModel = PayViewModel()
    var body: some View {
        VStack {
            Text("잔액 : \(viewModel.balance)")
                .font(.headline)
            
            Button {
                Task {
                    if await viewModel.chargePaymoney(amount: 1000) {
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
                await viewModel.getBalance()
            }
        }
    }
}

#Preview {
    PayView()
}
