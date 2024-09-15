import SwiftUI
import RealityKit
import RealityKitContent
import Combine

struct VolumeView: View {
    
    @State private var subs: [EventSubscription] = []
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace  // Add environment variable to open immersive space
    @EnvironmentObject private var appModel: AppModel  // Access the app model for managing immersive spaces

    var body: some View {
        VStack {
            RealityView { content in
                // Load the door entity from your RealityKit bundle
                if let doorEntity = try? await Entity(named: "door", in: realityKitContentBundle) {

                    let floor = ModelEntity(mesh: .generatePlane(width: 20, depth: 20))
                    let floorPhysics = PhysicsBodyComponent(
                        massProperties: .default,
                        material: .generate(friction: 0.8, restitution: 0.1),
                        mode: .static
                    )
                    floor.components[OpacityComponent.self] = .init(opacity: 0)  // Make the floor invisible
                    
                    floor.components.set(floorPhysics)
                    floor.collision = CollisionComponent(
                        shapes: [.generateBox(width: 20, height: -0.01, depth: 20)]
                    )
                    
                    // Anchor for the floor
                    let anchor = AnchorEntity(.plane(.horizontal, classification: .floor, minimumBounds: [0.5, 0.5]))
                    anchor.addChild(floor)
                    
                    // Set the door entity (cube) with a trigger volume
                    if let door = doorEntity.findEntity(named: "Cube") {
                        let cubeCollision = CollisionComponent(
                            shapes: [.generateBox(width: 5, height: 10, depth: 2.5)], mode: .trigger
                        )
                        door.components.set(cubeCollision)  // Set collision component

                        // Subscribe to collision events on the door
                        let event = content.subscribe(to: CollisionEvents.Began.self, on: door) { ce in
                            if ce.entityA.name == "RightHand" || ce.entityB.name == "RightHand" {
                                // Trigger immersive space when the player "walks" into the door
                                triggerImmersiveSpace()
                            }
                        }
                        
                        // Append the event subscription
                        DispatchQueue.main.async {
                            subs.append(event)
                        }
                    }
                    
                    content.add(anchor)
                    content.add(doorEntity)
                    
                    // Create hand entities (representing the player for now)
                    let rightHandAnchor = AnchorEntity(.hand(.right, location: .indexFingerTip))
                    let handSphere = MeshResource.generateSphere(radius: 0.01)
                    let handMaterial = SimpleMaterial(color: .red, isMetallic: false)
                    
                    let rightHandEntity = ModelEntity(mesh: handSphere, materials: [handMaterial])
                    rightHandEntity.name = "RightHand"
                    rightHandEntity.physicsBody = PhysicsBodyComponent(
                        massProperties: .default,
                        material: .generate(friction: 0.5, restitution: 0.3),
                        mode: .kinematic
                    )
                    rightHandEntity.collision = CollisionComponent(
                        shapes: [.generateSphere(radius: 0.01)],
                        mode: .trigger  // Set as trigger
                    )
                    
                    rightHandAnchor.addChild(rightHandEntity)
                    content.add(rightHandAnchor)
                }
            }
        }
    }
    
    // Function to trigger immersive space transition
    func triggerImmersiveSpace() {
        Task {
            // Ensure we are transitioning into the immersive space
            appModel.immersiveSpaceState = .inTransition
            
            // Open the immersive space
            switch await openImmersiveSpace(id: "space1") {
            case .opened:
                appModel.immersiveSpaceState = .open
                print("Entered Immersive Space!")
            case .userCancelled, .error:
                fallthrough
            @unknown default:
                appModel.immersiveSpaceState = .closed
                print("Failed to Enter Immersive Space.")
            }
        }
    }
}
