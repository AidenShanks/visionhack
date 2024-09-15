import SwiftUI

@MainActor
class AppModel: ObservableObject {
    @Published var currentImmersiveSpaceID: String = ""
    @Published var selectedImmersiveSpaceID: String = ""

    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }

    @Published var immersiveSpaceState = ImmersiveSpaceState.closed
}
