//
//  HitBall.swift
//  HitBall
//
//  Created by Kayden on 2025/1/17.
//

import Combine
import SwiftUI
@preconcurrency import GroupActivities
import RealityKit

struct HitBall: View {
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(AppModel.self) var appModel

    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var subscriptions = Set<AnyCancellable>()
    
    var body: some View {
        let gameState = GameScreen.from(state: appModel)
        VStack {
            Spacer()
            Group {
                switch gameState {
                case .start:
                    Welcome()
                case .play:
                    Play()
                case .score:
                    Score()
                }
            }
            .glassBackgroundEffect(
                in: RoundedRectangle(
                    cornerRadius: 32,
                    style: .continuous
                )
            )
        }
        .onReceive(timer) { _ in
            if appModel.isPlaying {
                if appModel.timeLeft > 0 && !appModel.isPaused {
                    appModel.timeLeft -= 1
                    if (appModel.timeLeft % 5 == 0 || appModel.timeLeft == AppModel.gameTime - 1) && appModel.timeLeft > 4 {
                        Task { @MainActor () -> Void in
                            do {
                                _ = try await spawnBall()
                                
                            } catch {
                                print("Error spawning a ball:", error)
                            }
                            
                        }
                    }
                } else if appModel.timeLeft == 0 {
                    print("Game finished.")
                    appModel.isFinished = true
                    appModel.timeLeft = -1
                }
            }

        }
    }
}

enum GameScreen {
    static func from(state: AppModel) -> Self {
        if !state.isPlaying {
            return .start
        } else if state.isPlaying {
            if !state.isFinished {
                return .play
            } else {
                return .score
            }
        }
        return .start
    }
    
    case start
    case play
    case score
}
