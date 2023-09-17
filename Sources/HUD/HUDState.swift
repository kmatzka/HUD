//
//  HUDState.swift
//  HUD
//
//  Created by Klaus Matzka on 15.09.23.
//

import SwiftUI

/// The environmentObject that saves the HUD state.
///
/// Inject at the top level of your view tree, typically within the app's WindowGroup() view.
/// Use function 'show(autoClosureDelay:content:)' to configure and show the HUD from within any view.
public class HUDState: ObservableObject {
    
    @Published public var isPresented: Bool
    public var autoClosureDelay: Int
    public var content: any View
    
    public init(isPresented: Bool = false,
                autoClosureDelay: Int = 3,
                content: any View = Text(" -- no hud content -- "))
    {
        self.isPresented = isPresented
        self.autoClosureDelay = autoClosureDelay
        self.content = content
    }
    
    /// Configures and shows a HUD.
    /// - Parameters:
    ///   - autoClosureDelay: Seconds the HUD shows before it closes automativally.
    ///   - content: The HUD capsule content to show.
    public func show(autoClosureDelay: Int = 3, content: any View) {
        self.content = content.foregroundColor(Color(.label))
        self.autoClosureDelay = autoClosureDelay
        
        withAnimation {
            self.isPresented = true
        }
    }
    
    /// Configures a HUD, without showing it.
    /// - Parameters:
    ///   - autoClosureDelay: Seconds the HUD shows before it closes automativally.
    ///   - content: The HUD capsule content to show.
    public func configue(autoClosureDelay: Int = 3, content: any View) {
        self.content = content.foregroundColor(Color(.label))
        self.autoClosureDelay = autoClosureDelay
    }
}
