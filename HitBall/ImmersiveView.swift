//
//  ImmersiveView.swift
//  HitBall
//
//  Created by Kayden on 2025/1/15.
//

import SwiftUI
import RealityKit
import RealityKitContent
import Combine

struct ImmersiveView: View {
    
    //    @ObservedObject var simulatorHandTrackingProvider = SimulatorHandTrackingProvider()
    //    let bonjour = BonjourSession(configuration: .default)
    
    var body: some View {
        
        RealityView { content in
            
            content.add(spaceOrigin)
//            headAnchor = AnchorEntity(.head)
            
            //TODO: hand hit
            //            anchorHead.anchoring.trackingMode = .continuous
            //            content.add(anchorHead)
            //            simulatorHandTrackingProvider.start()
            //            simulatorHandTrackingProvider.addHands(content, anchorHead)
            
        } update: { updateContent in
            // Access Hand data here
            // ie: simulatorHandTrackingProvider.leftHand.handPose
        }
    }
    
//TODO: Tap Gesture ? handle evnets ? collisions
//    func handleTap() {
//        guard let cameraEntity = spaceOrigin.children.first(where: { $0.name == "Camera" }) else {
//            print("Camera entity not found in the scene.")
//            return
//        }
//        
//        let cameraTransform = cameraEntity.transform
//        let cameraPosition = cameraTransform.translation
//        
//        for ball in ballEntities {
//            let ballPosition = ball.position(relativeTo: nil)
//            let rayDirection = normalize(ballPosition - cameraPosition)
//            
//            if isBallHit(rayOrigin: cameraPosition, rayDirection: rayDirection, ballPosition: ballPosition) {
//                playDestroyEffect(for: ball)
//                ball.removeFromParent()
//                ballEntities.removeAll { $0 == ball }
//                break
//            }
//        }
//    }
//
//    func isBallHit(rayOrigin: SIMD3<Float>, rayDirection: SIMD3<Float>, ballPosition: SIMD3<Float>) -> Bool {
//        let distance = length(ballPosition - rayOrigin)
//        let hitTolerance: Float = 0.5
//        return distance < hitTolerance
//    }
//    
//    func playDestroyEffect(for entity: Entity) {
//        let explosion = ModelEntity(mesh: .generateSphere(radius: 0.8))
//        explosion.model?.materials = [SimpleMaterial(color: .yellow, isMetallic: false)]
//        explosion.position = entity.position
//        //            anchorEntity.addChild(explosion)
//        spaceOrigin.addChild(explosion)
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            explosion.removeFromParent()
//        }
//    }
}

func eventHasTargets(event: CollisionEvents.Began, matching names: [String]) -> Entity? {
    for targetName in names {
        if let target = eventHasTarget(event: event, matching: targetName) {
            return target
        }
    }
    return nil
}

func eventHasTarget(event: CollisionEvents.Began, matching targetName: String) -> Entity? {
    let aParentBeam = event.entityA[parentMatching: targetName]
    let aChildBeam = event.entityA[descendentMatching: targetName]
    let bParentBeam = event.entityB[parentMatching: targetName]
    let bChildBeam = event.entityB[descendentMatching: targetName]
    
    if aParentBeam == nil && aChildBeam == nil && bParentBeam == nil && bChildBeam == nil {
        return nil
    }
    
    var beam: Entity?
    if aParentBeam != nil || aChildBeam != nil {
        beam = (aParentBeam == nil) ? aChildBeam : aParentBeam
    } else if bParentBeam != nil || bChildBeam != nil {
        beam = (bParentBeam == nil) ? bChildBeam : bParentBeam
    }
    
    return beam
}
