//
//  HUDState.swift
//  HUD
//
//  Created by Klaus Matzka on 15.09.23.
//

import SwiftUI

public class HUDState: ObservableObject {
    
    @Published public var isPresented: Bool
    public var autoClosureDelay: Int
    public var view: any View
    
    public init(isPresented: Bool = false,
                autoClosureDelay: Int = 4,
                view: any View = Text(" -- no hud content -- "))
    {
        self.isPresented = isPresented
        self.autoClosureDelay = autoClosureDelay
        self.view = view
    }
    
    public func show(autoClosureDelay: Int = 4, view: any View) {
        self.view = view.foregroundColor(Color(.label))
        self.autoClosureDelay = autoClosureDelay
        
        withAnimation {
            self.isPresented = true
        }
    }
    
    public func configue(autoClosureDelay: Int = 4, view: any View) {
        self.view = view.foregroundColor(Color(.label))
        self.autoClosureDelay = autoClosureDelay
    }
}
