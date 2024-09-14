import SwiftUI
import RealityKit
import RealityKitContent


struct ContentView: View {
    var body: some View {
        ZStack {
            // Toggle buttons
            VStack(){
                ToggleImmersiveSpaceButton(immersiveSpaceID: "space1", label: "Open Space 1")
                
                ToggleImmersiveSpaceButton(immersiveSpaceID: "space2", label: "Open Space 2")
                
                ToggleImmersiveSpaceButton(immersiveSpaceID: "door", label: "Open teleportation Door")
                
            }
            // RealityView displaying the door model
//            RealityView { content in
//                if let doorEntity = try? await Entity(named: "door", in: realityKitContentBundle) {
//                    content.add(doorEntity)
//                }
//            }
        }.padding()
    }
}

