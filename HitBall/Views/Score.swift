//
//  Score.swift
//  HitBall
//
//  Created by Kayden on 2025/1/17.
//

import SwiftUI

struct Score: View {
    @Environment(AppModel.self) var appModel
    @Environment(\.dismissImmersiveSpace) var dismissImmersiveSpace

    var body: some View {
        VStack(spacing: 15) {
            Text("Show Over~", comment: "")
                .font(.system(size: 36, weight: .bold))
            Group {
                Button {
                    Task {
                        await goBackToStart()
                    }
                } label: {
                    Text("Back to Welcome", comment: "")
                        .frame(maxWidth: .infinity)
                }
            }
            .frame(width: 260)
        }
        
        .padding(15)
        .frame(width: 634, height: 499)
    }
    
    @MainActor
    func goBackToStart() async {
        appModel.reset()
        await dismissImmersiveSpace()
    }
}
