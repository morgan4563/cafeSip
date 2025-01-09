//
//  AddressSelectionView.swift
//  cafeSip
//
//  Created by hyunMac on 1/10/25.
//

import SwiftUI
import NMapsMap

struct AddressSelectionView: View {
    var body: some View {
        VStack {
            NaverMapView()
                .frame(width: .infinity, height: 600)
            Rectangle()
                .fill(.white)
                .frame(width: .infinity, height: .infinity)
                .overlay() {
                    VStack {
                        Text("주소주소주소주소주소주소")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black)
                        Button("이 위치로 주소 등록") {
                            
                        }
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(width: 363, height: 42)
                        .background(.brown)
                        .clipShape(Rectangle())
                    }
                    
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
