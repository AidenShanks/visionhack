import SwiftUI
import RealityKit
import RealityKitContent
import RoomProMax1
import Combine

struct VolumeView: View {
    var body: some View {
        VStack {
            RealityView { content in
                    // Load the door entity from your RealityKit bundle
                    if let doorEntity = try? await Entity(named: "door", in: roomProMax1Bundle) {
                        
                        // Add collision component to the door
                        doorEntity.generateCollisionShapes(recursive: true)
                        
                        // Add the door entity to the scene
                        content.add(doorEntity)
                        
                            // Create and add hand collision entities for both hands
                            let rightHandAnchor = AnchorEntity(.hand(.right, location: .indexFingerTip))
                            let leftHandAnchor = AnchorEntity(.hand(.left, location: .indexFingerTip))

                            let rightHandEntity = createHandCollisionEntity()
                            let leftHandEntity = createHandCollisionEntity()
                            
                            rightHandAnchor.addChild(rightHandEntity)
                            leftHandAnchor.addChild(leftHandEntity)
                            
                            content.add(rightHandAnchor)
                            content.add(leftHandAnchor)
                        
                        // Set up collision interaction with the door
                        setupInteraction(for: doorEntity)
                    }
                }
            }
        }
    

    
    // Function to create a small sphere entity for hand collision detection
    func createHandCollisionEntity() -> Entity {
        let handSphere = MeshResource.generateSphere(radius: 0.01)  // Small sphere for fingertip
        let handMaterial = SimpleMaterial(color: .red, isMetallic: false)
        let handEntity = ModelEntity(mesh: handSphere, materials: [handMaterial])
        
        // Add collision and physics components for the hand entity
        handEntity.physicsBody = PhysicsBodyComponent(mode: .kinematic)
        handEntity.collision = CollisionComponent(
            shapes: [.generateSphere(radius: 0.01)]
        )
        
        return handEntity
    }
    
    // Function to set up interaction between hand and door entity
    func setupInteraction(for doorEntity: Entity) {
        doorEntity.scene?.subscribe(to: CollisionEvents.Began.self, on: doorEntity) { event in
            // Check if the collision was with one of the hand entities
            if event.entityA.name == "hand" || event.entityB.name == "hand" {
                print("User touched the door with their hand.")
            }
        }.store(in: &cancellables)
    }
    
    // To hold the event subscription
    @State private var cancellables = Set<AnyCancellable>()
}
