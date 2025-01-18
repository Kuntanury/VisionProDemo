//
//  Untitled.swift
//  HitBall
//
//  Created by Kayden on 2025/1/17.
//

import RealityKit
import SwiftUI

var hitCounts: [String: Int] = [:]
var ballIsHit: [String: Bool] = [:]

@MainActor
func handleCollisionStart(for event: CollisionEvents.Began, appModel: AppModel) async throws {
    if appModel.isPaused {
        return
    }
    print("--- Collision ---",
          event.entityA.name, event.entityB.name,
          event.entityA.children.count, event.entityA.parent?.name as Any,
          event.entityB.children.count, event.entityB.parent?.name as Any
    )
    
    guard let ball = eventHasTarget(event: event, matching: "Ball") else {
        print("No cloud found in collision")
        return
    }
    
    let minBallHits = 1
    if hitCounts[ball.name] == nil {
        hitCounts[ball.name] = 0
    }
    hitCounts[ball.name]! += 1
    
    if hitCounts[ball.name]! >= minBallHits && ballIsHit[ball.name] == nil {
        ballIsHit[ball.name] = true
    }
    
    try handleBallHit(for: ball, appModel: appModel)
}

@MainActor
func handleBallHit(for ball: Entity, appModel: AppModel) throws {
    appModel.score += 1
    
    AccessibilityNotification.Announcement(String(localized: "Ball Hit")).post()
    
    if let fireworks = globalFireworks {
        let clone = fireworks.clone(recursive: true)
        clone.position.y += 0.3
        clone.position.z += 0.5
        ball.addChild(clone)
    }
    
    guard ball.descendentsWithModelComponent.first as? ModelEntity != nil else {
        fatalError("Cloud is not a model entity and has no descendents with a model entity.")
    }
    
    Task { @MainActor () -> Void in
        ball.removeFromParent()
    }
}
