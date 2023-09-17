# HUD
## Head Up Display

An simple HUD overlay view accessible from any SwiftUI view.

1. Add a **.modifier(HUDViewModifier())** to your top level view in the WindowGroup() of your App.
2. Create a **@StateObject hudState = HUDState()** in your App, and
3. Inject **hudState** into the environment at your top level view with **.environmentObject(hudState)**.

4. Show a HUD from anywhere in the view hierarchy by using **@EnvironmentObject var hudState: HUDState** and calling **hudState.show(content:)**.

HUDs can be dismissed by a **tap** or **swipe-up** gesture. Or auto close after **hudState.autoClosureDelay** seconds.


![](showHUD.gif)


Author: klaus.h.matzka@gmail.com

Lisence: MIT

Vienna/Austria/Europe, 09-2023
