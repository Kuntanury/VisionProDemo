//
//  HitBallApp.swift
//  HitBall
//
//  Created by Kayden on 2025/1/15.
//

import SwiftUI
import RealityKit

@main
struct HitBallApp: App {
    @State private var appModel = AppModel()
    
    var body: some SwiftUI.Scene {
        WindowGroup("HitBall", id: "hitBallApp") {
            HitBall()
                .environment(appModel)
                .onAppear {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                        return
                    }
                        
                    windowScene.requestGeometryUpdate(.Vision(resizingRestrictions: UIWindowScene.ResizingRestrictions.none))
                }
        }
        .windowStyle(.plain)
            

        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}


