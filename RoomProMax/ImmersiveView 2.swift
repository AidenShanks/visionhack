import SwiftUI
import RealityKit
import testproject

struct ImmersiveView2: View {
    @EnvironmentObject var appModel: AppModel

    var body: some View {
        RealityView { content in
            if let immersiveContentEntity = try? await Entity(named: "Garden", in: testprojectBundle) {
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
