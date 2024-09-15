import SwiftUI
import RealityKit
import testproject

struct ImmersiveView: View {
    @EnvironmentObject var appModel: AppModel

    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "minecraft", in: testprojectBundle) {
                content.add(immersiveContentEntity)

                // You might want to add some logic here to customize the immersive experience
                // based on which space was selected (using appModel.currentImmersiveSpaceID)
            }
        }
        .onDisappear {
            // Reset the selected space when leaving the immersive view
            appModel.selectedImmersiveSpaceID = ""
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}



//                        let event = content.subscribe(to: CollisionEvents.Began.self, on: rightHandEntity) { event in
//                            if event.entityA.name == "RightHand" || event.entityB == door {
//                                print("Collision detected with RightHand")
//                                //                            Task { @MainActor in
//                                //                                triggerImmersiveSpace()
//                                //                            }
//                            }
//                            sphere = content.entities.first?.findEntity(named: "Cube")
//
//                            print("💥 Collision between \(event.entityA.name) and \(event.entityB.name)")
//
//                    }
                    
//                    DispatchQueue.main.async {
//                        subs.append(event)
//                    }
