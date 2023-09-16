# HUD
## Head Up Display

An simple HUD overlay that you can access from any SwiftUI view.

1. Add a **.modifier(HUDViewModifier())** to your top level view in the WindowGroup() of your App.
2. Create a **@StateObject hudState = HUDState()** in your App.
3. Inject **hutState** into the environment at your top level view with **.environmentObject(hudState)**.

4. Show a HUD from anywhere in the view hierarchy by calling **hudState.show(hudContent:)**.

HUDs can be dismissed by a tap or swipe-up gesture. Or auto close after **hudState.autoClosureDelay** seconds.

Author: klaus.h.matzka@gmail.com

Lisence: MIT

Vienna/Austria/Europe, 09-2023
