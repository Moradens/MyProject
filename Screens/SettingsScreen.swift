//
//  SettingsScreen.swift
//  Screens
//
//  Created by Denis Moravec on 20.12.2023.
//

import SwiftUI

struct SettingsScreen: View {
    var body: some View {
        NavigationView {
        List {
            Section(header: Text("Účet")) {
                NavigationLink(destination: Text("Informace o účtu")) {
                    Text("Můj účet")
                }
                .navigationBarTitle("Nastavení")
                NavigationLink(destination: Text("Nastavení účtu")) {
                    Text("Nastavení")
                }
            }
            
            Section(header: Text("Nastavení aplikace")) {
                NavigationLink(destination: Text("Nastavení notifikací")) {
                    Text("Notifikace")
                }
                NavigationLink(destination: LookApp()) {
                    Text("Vzhled")
                }
                NavigationLink(destination: Text("Podmínky s použitím fotoaparátu")) {
                    Text("Fotoaparát")
                }
            }
            
            Section(header: Text("O aplikaci")) {
                NavigationLink(destination: Text("Informace o aplikaci")) {
                    Text("O nás")
                }
                NavigationLink(destination: Text("Podmínky používání")) {
                    Text("Podmínky používání")
                }
                NavigationLink(destination: Text("Informace o databázi produktů")) {
                    Text("Databáze produktů")
                }
                }
            }
            .navigationBarTitle("Nastavení")
        }
    }
}



#Preview {
    SettingsScreen()
}
