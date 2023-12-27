//
//  CodeProcessor.swift
//  Screens
//
//  Created by Denis Moravec on 26.12.2023.
//

import SwiftUI
import Foundation

public class CodeProcessor {
    
    public init() {}
    
    public func processCode(givenCode: String) {
        guard givenCode.count <= 13, let rowNumber = findRowNumber(for: givenCode) else {
            print("Zadáno neplatné číslo.")
            return
        }
        
        let columnsToCheck: [String] = ["E", "F"] // Můžete přidat další sloupce podle potřeby
        
        for column in columnsToCheck {
            if let value = getValue(at: rowNumber, column: column) {
                switch value {
                case "1":
                    print("Potravina označena obrázkem jako bezlepková.")
                case "2":
                    print("Potravina označena obrázkem.")
                case "3":
                    print("Potravina neoznačena textem ani obrázkem.")
                case "4":
                    print("Potravina neoznačena textem ani obrázkem; je bezlepková.")
                case "5":
                    print("Nejíst obsahuje lepek.")
                default:
                    print("Neplatná hodnota v buňce \(column)\(rowNumber).")
                }
            }
        }
    }

    private func findRowNumber(for givenCode: String) -> Int? {
        // Zde implementujte logiku pro hledání řádku v tabulce na základě givenCode
        // Vráťte číslo řádku nebo nil, pokud nebyl nalezen žádný řádek
        return nil
    }

    private func getValue(at row: Int, column: String) -> String? {
        // Zde implementujte logiku pro získání hodnoty z tabulky na základě řádku a sloupce
        // Vráťte hodnotu nebo nil, pokud nebyla nalezena žádná hodnota
        return nil
    }
}
