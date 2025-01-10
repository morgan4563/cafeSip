//
//  AddressSelectionView.swift
//  cafeSip
//
//  Created by hyunMac on 1/10/25.
//

import SwiftUI
import NMapsMap

struct AddressSelectionView: View {
    @State var address = "서울시 용산구 땡땡로"
    var body: some View {
        VStack {
            Text("매장 등록")
                .font(.title)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            Text("영업중인 매장을 등록합니다. 지도를 통해서 주소확인후 해당 주소로 설정을 통해 상세 주소를 입력해 주세요.")
                .font(.callout)
                .frame(maxWidth: .infinity,alignment: .leading)
                .padding(.horizontal)
            
            Divider()
            
            NaverMapView()
                .frame(maxWidth: .infinity)
            Rectangle()
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .overlay(alignment: .leading) {
                    Text(address)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding()
                }
            
            NavigationLink {
                AddressSelectionView()
            } label: {
                Text("해당 주소로 설정")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 363, height: 42)
                    .background(.brown)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            
        }
    }
}

struct NaverMapView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let mapView = NMFMapView(frame: .zero)
        
        mapView.positionMode = .direction
        mapView.zoomLevel = 10
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}

#Preview {
    AddressSelectionView()
}
