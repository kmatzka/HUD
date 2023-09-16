# HUD
## Head Up Display

An simple HUD overlay view modifier, that you add to your SwiftUI top level view.
Create a HUDState and inject it into the environment at the top level view with .environmentObject(hudState).

Show a HUD from anywhere in the view hierarchy by calling hudState.show(hudContent:).

HUDs can be dismissed by a tap or drag up gesture. Or auto close after hudState.autoClosureDelay seconds.

Author: klaus.h.matzka@gmail.com

Lisence: MIT

Vienna/Austria/Europe, 09-2023
