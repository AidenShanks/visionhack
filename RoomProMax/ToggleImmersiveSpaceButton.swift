//
//  ToggleImmersiveSpaceButton.swift
//  RoomProMaxApp
//
//  Created by Alakh Naik on 9/14/24.
//

import SwiftUI

struct ToggleImmersiveSpaceButton: View {

    @EnvironmentObject private var appModel: AppModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    let immersiveSpaceID: String
    let label: String

    var body: some View {
        Button {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                case .open where appModel.currentImmersiveSpaceID == immersiveSpaceID:
                    // Close the current immersive space
                    appModel.immersiveSpaceState = .inTransition
                    await dismissImmersiveSpace()
                default:
                    // Close any open immersive space
                    if appModel.immersiveSpaceState == .open {
                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                    }
                    // Open the new immersive space
                    appModel.currentImmersiveSpaceID = immersiveSpaceID
                    appModel.immersiveSpaceState = .inTransition
                    switch await openImmersiveSpace(id: immersiveSpaceID) {
                    case .opened:
                        break
                    case .userCancelled, .error:
                        fallthrough
                    @unknown default:
                        appModel.immersiveSpaceState = .closed
                    }
                }
            }
        } label: {
            Text(label)
        }
        .disabled(appModel.immersiveSpaceState == .inTransition)
        .animation(.none, value: appModel.immersiveSpaceState)
        .fontWeight(.semibold)
    }
}
