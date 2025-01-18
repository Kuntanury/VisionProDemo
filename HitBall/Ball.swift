//
//  Ball.swift
//  HitBall
//
//  Created by Kayden on 2025/1/16.
//

import Accessibility
import Spatial
import RealityKit
import SwiftUI

@MainActor
func spawnBall() async throws -> Entity {
    let angle = Float.random(in: 0...2 * .pi)
    let x = cos(angle)
    let y = sin(angle)
    let startPoint = Point3D(x: x, y: y, z: -30)
    let ball = try await spawnBallExact(start: startPoint)
    ballEntities.append(ball)
    return ball
}

@MainActor
func spawnBallExact(start: Point3D) async throws -> Entity {
    
    let sphereMesh = MeshResource.generateSphere(radius: 0.5)
    let sphereMaterial = SimpleMaterial(color: UIColor.random, roughness: 0.8, isMetallic: true)

    let ball = ModelEntity(mesh: sphereMesh, materials: [sphereMaterial])
    ball.generateCollisionShapes(recursive: true)
    ball.name = "Ball\(ballNumber)"
    ball.position = simd_float(start.vector)
    ballNumber += 1
    
    var accessibilityComponent = AccessibilityComponent()
    accessibilityComponent.label = "Ball"
    accessibilityComponent.isAccessibilityElement = true
    ball.components[AccessibilityComponent.self] = accessibilityComponent
    
    let end = Point3D(
        x: 0.0,
        y: 0.0,
        z: -4
    )
    let line = FromToByAnimation<Transform>(
                            name: "line",
                            from: .init(scale: .init(repeating: 1), translation: ball.position),
                            to: .init(scale: .init(repeating: 1), translation: simd_float(end.vector)),
                            duration: CloudSpawnParameters.speed,
                            bindTarget: .transform
                        )
    
    let animation = try! AnimationResource
        .generate(with: line)
    
    ball.playAnimation(animation, transitionDuration: 0.1, startsPaused: false)
    
    spaceOrigin.addChild(ball)
    
    return ball
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: Double.random(in: 0...0.7),
            green: Double.random(in: 0...0.7),
            blue: Double.random(in: 0...0.7), alpha: 1
        )
    }
}

struct CloudSpawnParameters {
    static var deltaX = 0.0
    static var deltaY = 0.0
    static var deltaZ = 0.0
    
    static var speed = 5.0
}
