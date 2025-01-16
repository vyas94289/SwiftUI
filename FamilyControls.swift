import FamilyControls
import DeviceActivity

struct ContentView1: View {
    @State private var selection = FamilyActivitySelection()
    @State private var isPresented = false
    @State private var authorizationCenter = AuthorizationCenter.shared
    
    var body: some View {
        ZStack {
            Button("Select Apps to Restrict") {
                isPresented = true
            }
            .familyActivityPicker(isPresented: $isPresented, selection: $selection)
            .onChange(of: selection) { newSelection in
                print("Selected apps: \(newSelection.applicationTokens)")
            }
        }
        .onAppear {
            requestAuthorization()
        }
    }
    
    func requestAuthorization() {
            authorizationCenter.requestAuthorization { result in
                switch result {
                case .success:
                    print("Authorization successful")
                case .failure(let error):
                    print("Authorization failed: \(error.localizedDescription)")
                }
            }
        }
}
