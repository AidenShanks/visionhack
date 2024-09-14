import SwiftUI

/// Maintains app-wide state
@MainActor
class AppModel: ObservableObject {
    // Current immersive space ID
    @Published var currentImmersiveSpaceID: String = ""

    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }

    @Published var immersiveSpaceState = ImmersiveSpaceState.closed
}
