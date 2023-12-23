import SwiftUI

struct ContentView: View {
    @AppStorage("isLightModeEnabled") private var isLightModeEnabled = false
    @AppStorage("isNightModeEnabled") private var isNightModeEnabled = false
    @AppStorage("isAutoModeEnabled") private var isAutoModeEnabled = true

    var body: some View {
        TabView {
            // Profile
            ProfileScreen()
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profil")
                }

            // Scan
            ScannerScreen()
                .tabItem {
                    Image(systemName: "barcode.viewfinder")
                    Text("Scan")
                }

            // Type your EAN code
            WriteScreen()
                .tabItem {
                    Image(systemName: "square.and.pencil.circle.fill")
                    Text("EAN")
                }

            // Settings
            SettingsScreen()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Nastavení")
                }
        }
        .onAppear {
            // Nastavit výchozí hodnoty, pokud nejsou uloženy žádné hodnoty
            if UserDefaults.standard.object(forKey: "isLightModeEnabled") == nil {
                UserDefaults.standard.set(isLightModeEnabled, forKey: "isLightModeEnabled")
            }
            if UserDefaults.standard.object(forKey: "isNightModeEnabled") == nil {
                UserDefaults.standard.set(isNightModeEnabled, forKey: "isNightModeEnabled")
            }
            if UserDefaults.standard.object(forKey: "isAutoModeEnabled") == nil {
                UserDefaults.standard.set(isAutoModeEnabled, forKey: "isAutoModeEnabled")
            }

            // Načtení uložených hodnot
            isLightModeEnabled = UserDefaults.standard.bool(forKey: "isLightModeEnabled")
            isNightModeEnabled = UserDefaults.standard.bool(forKey: "isNightModeEnabled")
            isAutoModeEnabled = UserDefaults.standard.bool(forKey: "isAutoModeEnabled")

            // Aktualizace vzhledu
            if isAutoModeEnabled {
                updateAppearance()
            } else if isNightModeEnabled {
                updateAppearance()
            } else {
                updateAppearance()
            }
        }
    }

    private func updateAppearance() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        if isNightModeEnabled {
            window.overrideUserInterfaceStyle = .dark
        } else {
            window.overrideUserInterfaceStyle = isLightModeEnabled ? .light : .unspecified
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
