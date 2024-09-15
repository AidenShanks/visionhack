//import SwiftUI
//import RealityKit
//import RealityKitContent
//import Combine
//import RoomProMax1
//
//struct VolumeView: View {
//    @Binding var isVisible: Bool
//    @State private var doorEntity: Entity?
//    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
//    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
//    @EnvironmentObject private var appModel: AppModel
//    
//    var body: some View {
//        VStack {
//            RealityView { content in
//                // Load the door entity from your RealityKit bundle
//                if let doorEntity = try? await Entity.load(named: "door",in: roomProMax1Bundle) {
//                    print("Door entity loaded: \(doorEntity.name)")
//                    
//                    // Setup floor
//                    let floor = ModelEntity(mesh: .generatePlane(width: 20, depth: 20))
//                    let floorPhysics = PhysicsBodyComponent(
//                        massProperties: .default,
//                        material: .generate(friction: 0.8, restitution: 0.1),
//                        mode: .static
//                    )
//                    floor.components[OpacityComponent.self] = .init(opacity: 0)  // Make the floor invisible
//                    floor.components.set(floorPhysics)
//                    floor.collision = CollisionComponent(
//                        shapes: [.generateBox(width: 20, height: 0.01, depth: 20)]
//                    )
//                    
//                    // Anchor for the floor
//                    let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.5, 0.5]))
//                    anchor.addChild(floor)
//                    content.add(anchor)
//                    print("Floor added to scene")
//                    
//                    // Setup door
//                    if let door = doorEntity.findEntity(named: "Cube") {
//                        print("Door cube found: \(door.name)")
//                        door.name = "DoorCube"
//                        
//                        content.add(doorEntity)
//                        print("Door entity added to scene")
//                        self.doorEntity = doorEntity  // Store the whole door entity
//                    } else {
//                        print("Failed to find 'Cube' entity in door")
//                    }
//                } else {
//                    print("Failed to load door entity")
//                }
//            } update: { content in
//                if let doorEntity = self.doorEntity {
//                    doorEntity.isEnabled = isVisible
//                }
//            }
//            .gesture(
//                SpatialTapGesture()
//                    .targetedToAnyEntity()
//                    .onEnded { value in
//                        let tappedEntity = value.entity
//                        if tappedEntity.name == "DoorCube" || tappedEntity.name == "door" {
//                            print("Door tapped!")
//                            Task { @MainActor in
//                                await triggerImmersiveSpace()
//                            }
//                        }
//                    }
//            )
//            .onAppear {
//                print("Volume View appeared")
//            }
//        }
//    }
//    
//    func triggerImmersiveSpace() async {
//        guard !appModel.selectedImmersiveSpaceID.isEmpty else {
//            print("No space selected")
//            return
//        }
//        
//        // Check if an immersive space is already open or in transition
//        guard appModel.immersiveSpaceState == .closed else {
//            print("An immersive space is already open or in transition")
//            return
//        }
//        
//        print(appModel.immersiveSpaceState)
//        
//        appModel.immersiveSpaceState = .inTransition
//        switch await openImmersiveSpace(id: appModel.selectedImmersiveSpaceID) {
//        case .opened:
//            appModel.immersiveSpaceState = .open
//            appModel.currentImmersiveSpaceID = appModel.selectedImmersiveSpaceID
//            print("Entered Immersive Space: \(appModel.selectedImmersiveSpaceID)")
//        case .userCancelled, .error:
//            fallthrough
//        @unknown default:
//            appModel.immersiveSpaceState = .closed
//            appModel.currentImmersiveSpaceID = ""
//            print("Failed to Enter Immersive Space.")
//        }
//    }
//}
