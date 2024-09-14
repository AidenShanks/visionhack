import SwiftUI

@main
struct RoomProMaxApp: App {

    @State private var appModel = AppModel()
    @State private var avPlayerViewModel = AVPlayerViewModel()
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var showVolume = false
    @State private var volumeShown = false
    

    var body: some Scene {
        WindowGroup {
            if avPlayerViewModel.isPlaying {
                AVPlayerView(viewModel: avPlayerViewModel)
                    .environmentObject(appModel)
            } else {
                ContentView()
                    .environmentObject(appModel)
            }
        }
        
        ImmersiveSpace(id: "door") {
            VolumeView()
                .onChange(of: showVolume) { _, newValue in
                    if newValue {
                        openWindow(id: "Volume")
                        volumeShown = true
                    } else {
                        dismissWindow(id: "Volume")
                        volumeShown = false
                    }
                }
        }

        // Immersive Space 1
        ImmersiveSpace(id: "space1") {
            ImmersiveView()
                .environmentObject(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                    avPlayerViewModel.play()
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    avPlayerViewModel.reset()
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)

        // Immersive Space 2
        ImmersiveSpace(id: "space2") {
            ImmersiveView2()
                .environmentObject(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                    avPlayerViewModel.play()
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                    avPlayerViewModel.reset()
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)

        // Add more ImmersiveSpaces as needed
    }
}
