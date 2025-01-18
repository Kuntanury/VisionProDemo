//
//  AppModel.swift
//  HitBall
//
//  Created by Kayden on 2025/1/15.
//

import SwiftUI
import RealityKit

@Observable
class AppModel {
    var isPlaying = false
    var isPaused = false {
        didSet {
            if isPaused == true {
                for child in spaceOrigin.children {
                    if child.name.contains("Ball") {
                        child.stopAllAnimations(recursive: false)
                    }
                }
            } else {
                for child in spaceOrigin.children {
                    if child.name.contains("Ball") {
                        let end = Point3D(
                            x: 0.0,
                            y: 0.0,
                            z: -4
                        )
                        
                        
                        let line = FromToByAnimation<Transform>(
                                                name: "line",
                                                from: .init(scale: .init(repeating: 1), translation: child.position),
                                                to: .init(scale: .init(repeating: 1), translation: simd_float(end.vector)),
                                                duration: CloudSpawnParameters.speed,
                                                bindTarget: .transform
                                            )
                        
                        let animation = try! AnimationResource
                            .generate(with: line)
                        
                        child.playAnimation(animation, transitionDuration: 0.0, startsPaused: false)
                    }
                }
            }
        }
    }
    
    static let gameTime = 35
    var timeLeft = gameTime
    var score = 0
    
    let immersiveSpaceID = "ImmersiveSpace"
    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed
    
    var isFinished = false {
        didSet {
            if isFinished == true {
                clear()
                
            }
        }
    }
    
    func clear() {
        spaceOrigin.children.removeAll()
    }
    
    func reset() {
        isPlaying = false
        isPaused = false
        isFinished = false
        timeLeft = AppModel.gameTime
        ballNumber = 0
        hitCounts = [:]
        ballIsHit = [:]
        ballEntities = []
        clear()
    }
}
