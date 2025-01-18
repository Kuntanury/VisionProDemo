//
//  Welcome.swift
//  HitBall
//
//  Created by Kayden on 2025/1/17.
//

import SwiftUI
import GroupActivities

struct Welcome: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @StateObject private var groupStateObserver = GroupStateObserver()
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Text("Hit Ball", comment: "")
                .font(.system(size: 30, weight: .bold))
            
            Button {
                appModel.isPlaying = true
                appModel.timeLeft = AppModel.gameTime
                Task {
                    await openImmersiveSpace(id: appModel.immersiveSpaceID)
                }
            } label: {
                Text("Play", comment: "")
                    .frame(maxWidth: .infinity)
            }
            .font(.system(size: 16, weight: .bold))
            .frame(width: 200)
            Spacer()
        }
        .padding(.horizontal, 150)
        .frame(width: 634, height: 499)
    }
}
