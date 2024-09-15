import SwiftUI

@main
struct RoomProMaxApp: App {

    @StateObject private var appModel = AppModel()
    @StateObject private var avPlayerViewModel = AVPlayerViewModel()
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow
    @State private var showVolume = false
    @State private var volumeShown = false
    

    var body: some Scene {
        WindowGroup {
                    ContentView()
                        .environmentObject(appModel)
                }
                .windowResizability(.contentSize)



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

        // Immersive Space 3
        ImmersiveSpace(id: "space3") {
            ImmersiveView3()
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
        
        // Immersive Space 3
        ImmersiveSpace(id: "space4") {
            ImmersiveView4()
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
    }
}


//ImmersiveSpace(id: "door") {
//            VolumeView()
//                .environmentObject(appModel)
//                .onChange(of: showVolume) { _, newValue in
//                    if newValue {
//                        openWindow(id: "Volume")
//                        volumeShown = true
//                    } else {
//                        dismissWindow(id: "Volume")
//                        volumeShown = false
//                    }
//                }
//        }
