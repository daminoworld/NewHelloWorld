//
//  Shoe1.swift
//  World
//
//  Created by Damin on 4/28/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import SwiftUI
import RealityKit
import WorldAssets

struct Shoe1: View {
    var scale: Float = 1
    var position: SIMD3<Float> = .zero
    
    @State private var shoes: Entity?

    var body: some View {
            RealityView { content in
                guard let shoes1 = await WorldAssets.entity(named: "Shoes1") else {
                    return
                }
//                shoes1.scale = .init(repeating: 0.5)
                content.add(shoes1)
                shoes1.setPosition(SIMD3<Float>(x: .zero, y: -0.05, z: 0.15), relativeTo: shoes1.parent)
                shoes = shoes1
            } update: { content in
                configure()
            }
    }
    
    private func configure() {
        shoes?.scale = SIMD3(repeating: scale)
        shoes?.position = position
    }
}
