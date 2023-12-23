import SwiftUI

struct LookApp: View {
    @AppStorage("isLightModeEnabled") private var isLightModeEnabled = false
    @AppStorage("isNightModeEnabled") private var isNightModeEnabled = false
    @AppStorage("isAutoModeEnabled") private var isAutoModeEnabled = true

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Trvale")) {
                    settingsItem(title: "Light Mode", isOn: $isLightModeEnabled)
                        .onChange(of: isLightModeEnabled) { newValue in
                            if newValue {
                                isNightModeEnabled = false
                                isAutoModeEnabled = false
                                updateAppearance()
                                saveSettings()
                            }
                        }

                    settingsItem(title: "Dark Mode", isOn: $isNightModeEnabled)
                        .onChange(of: isNightModeEnabled) { newValue in
                            if newValue {
                                isLightModeEnabled = false
                                isAutoModeEnabled = false
                                updateAppearance()
                                saveSettings()
                            }
                        }
                }

                Section(header: Text("Automaticky")) {
                    settingsItem(title: "Auto Mode", isOn: $isAutoModeEnabled)
                        .onChange(of: isAutoModeEnabled) { newValue in
                            if newValue {
                                isLightModeEnabled = false
                                isNightModeEnabled = false
                                updateAppearance()
                                saveSettings()
                            }
                        }
                }
            }
            
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("Vzhled")
            .onAppear {
                // Načti uložené hodnoty
                loadSettings()

                // Aktualizuj vzhled
                if isAutoModeEnabled {
                    updateAppearance()
                } else if isNightModeEnabled {
                    updateAppearance()
                } else {
                    updateAppearance()
                }
            }
        }
    }

    private func settingsItem(title: String, isOn: Binding<Bool>) -> some View {
        HStack {
            Text(title)
            Toggle("", isOn: isOn)
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

    private func saveSettings() {
        UserDefaults.standard.set(isLightModeEnabled, forKey: "isLightModeEnabled")
        UserDefaults.standard.set(isNightModeEnabled, forKey: "isNightModeEnabled")
        UserDefaults.standard.set(isAutoModeEnabled, forKey: "isAutoModeEnabled")
    }

    private func loadSettings() {
        isLightModeEnabled = UserDefaults.standard.bool(forKey: "isLightModeEnabled")
        isNightModeEnabled = UserDefaults.standard.bool(forKey: "isNightModeEnabled")
        isAutoModeEnabled = UserDefaults.standard.bool(forKey: "isAutoModeEnabled")
    }
}
