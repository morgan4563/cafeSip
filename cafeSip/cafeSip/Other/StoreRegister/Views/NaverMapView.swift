//
//  NaverMapView.swift
//  cafeSip
//
//  Created by hyunMac on 1/12/25.
//
import SwiftUI
import NMapsMap

struct NaverMapView: UIViewRepresentable {
    @Binding var viewModel: AddressSelectionViewModel
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        var parent: NaverMapView
        
        init(parent: NaverMapView) {
            self.parent = parent
        }
        
        func mapViewCameraIdle(_ mapView: NMFMapView) {
            let position = mapView.cameraPosition.target
            parent.viewModel.getRoadAddress(from: position)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> some UIView {
        let mapView = NMFNaverMapView(frame: .zero)
        mapView.mapView.addCameraDelegate(delegate: context.coordinator)
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}
