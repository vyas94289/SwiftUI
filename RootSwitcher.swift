import SwiftUI

@main
struct AlarmtekDemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var clientService: ClientService = .init()
    
    var body: some Scene {
        WindowGroup {
            RootSwitcher().environmentObject(clientService)
//            NavigationStack {
//                UNVCameraConfigScreen()
//            }.environmentObject(clientService)
        }
    }
}

struct RootSwitcher: View {
    @EnvironmentObject private var clientService: ClientService
    
    var body: some View {
        Group {
            switch clientService.appRootScreen {
            case .login:
                UserLoginView()
                    .transition(.slide)
            case .home:
                ContentView()
                    .transition(.slide)
            }
        }
        .animation(.easeInOut, value: clientService.appRootScreen)
    }
}
