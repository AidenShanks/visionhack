import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView2: View {
    @EnvironmentObject var appModel: AppModel
    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "Scene 1", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
            }
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
