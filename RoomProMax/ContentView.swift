import SwiftUI
import RealityKit

struct ContentView: View {
    
    @EnvironmentObject private var appModel: AppModel
    //    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    //    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @State private var isDoorVisible = false
    
    let spaceNames = [
        "Minecraft",
        "SnowZen",
        "MarioWorld",
        "WalmartAfterMidnight"
    ]
    
    var body: some View {
        ZStack{
            Text("RoomProMax")
                .font(.system(size: 200, weight: .bold))
                .foregroundColor(.white.opacity(0.4))
                .padding()
                .frame(maxWidth: .infinity, alignment: .trailing)
            
            ZStack() {
                Spacer()
                // Main content
                VStack(spacing: 20) {
                    // Space cards
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(Array(spaceNames.enumerated()), id: \.offset) { index, name in
                                SpaceCard(immersiveSpaceID: "space\(index + 1)", label: name)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    // Door toggle button
                    // Door toggle button
                    //                    Button(action: {
                    //                        isDoorVisible.toggle()
                    //                    }) {
                    //                        Text(isDoorVisible ? "Hide Door" : "Show Door")
                    //                            .padding()
                    //                            .cornerRadius(10)
                    //                            .fontWeight(.semibold)
                    //                    }
                    //                    .padding()
                    //                    .animation(.easeInOut, value: isDoorVisible)
                    
                    Spacer()
                }
            }
        }
    }
}

struct SpaceCard: View {
    @EnvironmentObject private var appModel: AppModel
    
    let immersiveSpaceID: String
    let label: String
    
    var body: some View {
        VStack {
            Text(label)
                           .font(.system(size: 50, weight: .bold))
                           .foregroundColor(.white)
                           .multilineTextAlignment(.center)
                           .padding()
            
            ToggleImmersiveSpaceButton(immersiveSpaceID: immersiveSpaceID, label: "Select")
                .padding()
        }
        .frame(width: 300, height: 400)
        .background(Color.gray.opacity(0.3))
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(appModel.selectedImmersiveSpaceID == immersiveSpaceID ? Color.blue : Color.clear, lineWidth: 2)
        )
        .animation(.easeInOut, value: appModel.selectedImmersiveSpaceID)
    }
}


// Door toggle button
//Button(action: {
//    toggleDoor()
//}) {
//    Label(isDoorVisible ? "Hide Door" : "Show Door", systemImage: "door.left.hand.open")
//        .padding()
//        .cornerRadius(10)
//}
//
//Spacer()
//
//HStack {
//    Spacer()
//    Text("RoomProMax")
//        .font(.system(size: 150, weight: .bold))
//        .foregroundColor(.white.opacity(0.2))
//        .padding()
//}
//
//struct SpaceCard: View {
//    @EnvironmentObject private var appModel: AppModel
//    
//    let immersiveSpaceID: String
//    let label: String
//    
//    var body: some View {
//        VStack {
//            Image(systemName: "photo")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 50, height: 50)
//                .foregroundColor(.gray)
//            
//            Text(label)
//                .foregroundColor(.white)
//            
//            Spacer()
//            
//            ToggleImmersiveSpaceButton(immersiveSpaceID: immersiveSpaceID, label: "Select")
//        }
//        .frame(width: 300, height: 400)
//        .background(Color.gray.opacity(0.3))
//        .cornerRadius(20)
//        .overlay(
//            RoundedRectangle(cornerRadius: 20)
//                .stroke(appModel.selectedImmersiveSpaceID == immersiveSpaceID ? Color.blue : Color.clear, lineWidth: 2)
//        )
//        .animation(.easeInOut, value: appModel.selectedImmersiveSpaceID)
//    }
//}
