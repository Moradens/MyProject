//
//  WriteScreen.swift
//  Screens
//
//  Created by Denis Moravec on 22.12.2023.
//

import SwiftUI
import Combine

struct WriteScreen: View {
    @State private var givenCode = ""
    let maxDigits = 13

    var body: some View {
        VStack{
            HStack {
                Spacer()
                TextField(
                    "Napište svůj čárový kód",
                    text: $givenCode
                )
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .onReceive(Just(givenCode)) { _ in formatCode() }
            }
            .padding() // Přidá padding pro oddělení od okolí
            HStack{
                Button(action: {removeSpaces()
                                // Zde můžete přidat akci pro ověření čárového kódu
                                print("Zkontrolovat: \(givenCode)")
                            }) {
                                Text("Zkontrolovat")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .cornerRadius(10)
                            }
                            .padding() // Přidá padding pro oddělení od okolí
            }
        }
    }
    
    func removeSpaces() {
            // Odstranění mezer z řetězce
            givenCode = givenCode.replacingOccurrences(of: " ", with: "")
        }

    func formatCode() {
        // Odstraní všechny nečíselné znaky (kromě mezer)
        givenCode = givenCode.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined()

        // Omezení délky na maxDigits
        givenCode = String(givenCode.prefix(maxDigits))

        // Vloží mezeru za první číslicí
        if givenCode.count > 1 {
            givenCode.insert(" ", at: givenCode.index(givenCode.startIndex, offsetBy: 1))
        }

        // Vloží mezeru za sedmou číslicí
        if givenCode.count > 7 {
            givenCode.insert(" ", at: givenCode.index(givenCode.startIndex, offsetBy: 7))
        }
    }
}

#Preview {
    WriteScreen()
}
