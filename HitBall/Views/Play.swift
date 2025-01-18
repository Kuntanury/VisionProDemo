//
//  Play.swift
//  HitBall
//
//  Created by Kayden on 2025/1/17.
//

import SwiftUI
import RealityKit
import Combine

struct Play: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(spacing: 0) {
                let progress = Float(appModel.timeLeft) / Float(AppModel.gameTime)
                
                HStack(alignment: .top) {
                    Button {
                        Task {
                            await dismissImmersiveSpace()
                        }
                        appModel.reset()
                    } label: {
                        Label("Back", systemImage: "chevron.backward")
                            .labelStyle(.iconOnly)
                    }
                    .offset(x: -23)
                    Text(verbatim: "\(String(format: "%02d", appModel.score))")
                        .font(.system(size: 60))
                        .bold()
                        .accessibilityLabel(Text("Score",
                                    comment: ""))
                        .accessibilityValue(Text(verbatim: "\(appModel.score)"))
                    .padding(.leading, 0)
                    .padding(.trailing, 60)
                }
                Text("score", comment: "")
                    .font(.system(size: 30))
                    .bold()
                    .accessibilityHidden(true)
                    .offset(y: -5)
                HStack {
                    ProgressView(value: (progress > 1.0 || progress < 0.0) ? 1.0 : progress)
                        .contentShape(.accessibility, Capsule().offset(y: -3))
                        .accessibilityLabel(Text(verbatim: ""))
                        .accessibilityValue(Text("\(appModel.timeLeft) seconds remaining"))
                        .tint(Color(uiColor: UIColor(red: 242 / 255, green: 68 / 255, blue: 206 / 255, alpha: 1.0)))
                        .padding(.vertical, 30)
                    Button {
                        appModel.isPaused.toggle()
                    } label: {
                        if appModel.isPaused {
                            Label(String(localized: "Play", comment: "Button to play the game"), systemImage: "play.fill")
                                .labelStyle(.iconOnly)
                        } else {
                            Label(String(localized: "Pause", comment: "Button to pause the game"), systemImage: "pause.fill")
                                .labelStyle(.iconOnly)
                        }
                    }
                    .padding(.trailing, 12)
                    .padding(.leading, 10)
                }
                .background(
                    .regularMaterial,
                    in: .rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 12,
                        bottomTrailingRadius: 12,
                        topTrailingRadius: 0,
                        style: .continuous
                    )
                )
                .frame(width: 260, height: 70)
                .offset(y: 15)
            }
            .padding(.vertical, 12)
        }
        .frame(width: 260)
    }
}
