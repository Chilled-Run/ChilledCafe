//
//  CheckLocationView.swift
//  ChilledCafe
//
//  Created by Kyubo Shim on 2022/12/08.
//

import SwiftUI
import CoreLocation

struct CheckCurrentLocationView: View {
    @EnvironmentObject var checkCurrentLocationViewModel: CheckCurrentLocationViewModel
    @Binding var arMainViewState: ARMainViewState
    
    var coordinate: CLLocationCoordinate2D? {
        checkCurrentLocationViewModel.lastSeenLocation?.coordinate
    }

    
    // 우리집 좌표
    // var targetCoordinate = CLLocationCoordinate2D(latitude: 36.0078958, longitude: 129.3345548)
    
    // 애플 아카데미 좌표
    var targetCoordinate = CLLocationCoordinate2D(latitude: 36.014152, longitude: 129.325798)
    
    var body: some View {
        
        // let distance: Double = coordinate?.distance(from: targetCoordinate) ?? 0
        if let distance = coordinate?.distance(from: targetCoordinate) {
            ZStack {
                Color.black.ignoresSafeArea()
                    .opacity(0.8)
                    .navigationBarHidden(true)
                if arMainViewState == .checkingLocation {
                    VStack{
                        LottieView(filename: "locater")
                            .frame(width: 150, height: 150)
                        Text("방문을 확인하고 있어요.")
                            .customTitle1()
                            .foregroundColor(.white)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            print(distance)
                            if distance <= 30 {
                                self.arMainViewState = .accessGranted
                            }
                            else {
                                self.arMainViewState = .accessDenied
                            }
                        })
                    }
                }
                
            }
        }
    }
}

