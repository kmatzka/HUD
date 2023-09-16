//
//  HUDView.swift
//  HUD
//
//  Created by Klaus Matzka on 15.09.23.
//

import SwiftUI

struct HUDView<Content: View>: View {
    
    @EnvironmentObject var hudState: HUDState
    @ViewBuilder let content: Content
    
    var body: some View {
        content
            .drawingGroup()
            .font(.footnote)
            .padding(.horizontal, 12)
            .padding(16)
            .background(.ultraThickMaterial, in: Capsule())
            .compositingGroup()
            .shadow(color: .black.opacity(0.3), radius: 5, x: 2, y: 2)
            .padding(.horizontal)
            .padding(.top, 10)
    }
}

struct HUDView_Preview_Provider: PreviewProvider {
        
    static var previewContent: some View {
        HStack(alignment: .center) {
            Image(systemName: "speaker.wave.3.fill")
                .foregroundColor(.purple)
                .font(.title2)
            Text("Download **HUD** from github today! **BEST SUSHI** quality! Please eat ***slowly***")
        }
    }
    
    static var previews: some View {
        HUDView(content: { previewContent })
    }
}

