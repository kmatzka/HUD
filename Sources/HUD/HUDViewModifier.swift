//
//  HUDViewModifier.swift
//  HUD
//
//  Created by Klaus Matzka on 15.09.23.
//

import SwiftUI

/// The ViewModifier that HUDifies a view hierarchy.
/// 
/// Apply at the top level of your view tree, typically at the app's WindowGroup() view:
///
/// `.modifier(HUDViewModifier())`
public struct HUDViewModifier: ViewModifier {
    
    @EnvironmentObject private var hudState: HUDState
    
    @State private var offset: CGFloat = 0.0
    @GestureState private var dragOffset: CGSize = .zero
    @State private var autoClosureTask: Task<Void, Never>?
    
    public init(offset: CGFloat = 0.0, autoClosureTask: Task<Void, Never>? = nil) {
        self.offset = offset
        self.autoClosureTask = autoClosureTask
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            // For the case that the 'content' view is not filling the whole screen,
            // we add a clear layer (behind content) that fills the whole display area,
            // so that the top-aligned .overlay always shows the HUD at the top of the screen.
            Color.clear
            content
        }
        .overlay(alignment: .top) {
            if hudState.isPresented {
                HUDView {
                    AnyView(hudState.content)
                }
                .zIndex(1)
                .offset(x: 0, y: offset + dragOffset.height)
                .transition(.asymmetric(insertion: .move(edge: .top).combined(with: .opacity),
                                        removal: .move(edge: .top).combined(with: .opacity)))
                .gesture(dragGesture)
                .gesture(tapGesture)
            }
        }
        .onChange(of: hudState.isPresented) { createHudAutoClosureTask($0) }
    }
    
    // MARK: - Gestures
    
    private var tapGesture: some Gesture {
        TapGesture()
            .onEnded { _ in
                withAnimation(.spring(response: 0.2, dampingFraction: 1.0)) {
                    hudState.isPresented = false
                    autoClosureTask?.cancel()
                    autoClosureTask = nil
                }
            }
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 5, coordinateSpace: .global)
        
            .updating($dragOffset) { value, dragOffset, transaction in
                if value.translation.height < 0 {
                    dragOffset = value.translation
                }
            }
        
            .onEnded { value in
                if value.translation.height < 0 {
                    offset += value.translation.height
                    withAnimation(.spring(response: 0.2, dampingFraction: 1.0)) {
                        offset += value.predictedEndLocation.y - value.translation.height
                        hudState.isPresented = false
                        offset = 0
                        autoClosureTask?.cancel()
                        autoClosureTask = nil
                    }
                }
            }
    }
    
    // MARK: - HUD auto closure task
    
    private func createHudAutoClosureTask(_ isPresented: Bool) {
        autoClosureTask?.cancel()
        autoClosureTask = nil
        
        guard isPresented else { return }
        
        autoClosureTask = Task {
            try? await Task.sleep(for: .seconds(hudState.autoClosureDelay))
            
            guard !Task.isCancelled else { return }
            
            DispatchQueue.main.async {
                withAnimation {
                    hudState.isPresented = false
                    offset = 0
                    autoClosureTask = nil
                }
            }
        }
    }
}
