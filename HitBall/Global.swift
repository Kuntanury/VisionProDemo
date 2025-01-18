//
//  Global.swift
//  HitBall
//
//  Created by Kayden on 2025/1/16.
//

import RealityKit
import Foundation

let spaceOrigin = Entity()
var ballEntities: [Entity] = []
var ballNumber = 0
var globalFireworks: Entity? = nil

struct BundleAssets {
    static let ballScene = "UpdatedGrumpyScene2"
    static let ballEntity = "BallScene"
    static let ball = "Ball.usdz"
}
