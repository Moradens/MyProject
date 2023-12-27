//
//  CodeProcessor.swift
//  Screens
//
//  Created by Denis Moravec on 26.12.2023.
//
import SwiftUI
import Foundation

struct Product {
    var id: Int
    var ean: String
    var name: String
    var manufacturer: String
    var col1: Int
    var col2: Int
    var col3: Int
    var col4: Int
    var col5: Int
    var foodGroups: String
    var whereToBuy: String
}

public class CodeProcessor {
    private let products: [Product]
    
    public init() {
        // Inicializujte array products s daty ze souboru nebo jiného zdroje
        // V tomto příkladu použijeme statická data
        self.products = [
            Product(id: 1, ean: "8594001248506", name: "bobík Maxi vanilkový 140g", manufacturer: "Bohušovická mlékárna a.s.", col1: 0, col2: 2, col3: 0, col4: 0, col5: 0, foodGroups: "jogurty", whereToBuy: ""),
            Product(id: 2, ean: "8008698005576", name: "Maestro Classic", manufacturer: "Dr. Schär AG", col1: 0, col2: 2, col3: 0, col4: 0, col5: 0, foodGroups: "pečivo", whereToBuy: ""),
            Product(id: 3, ean: "40084701", name: "Kinder Chocolate 8 tyčinek", manufacturer: "Ferrero Česká s.r.o.", col1: 0, col2: 0, col3: 3, col4: 0, col5: 0, foodGroups: "sladkosti", whereToBuy: ""),
            Product(id: 4, ean: "8008698001059", name: "Bon Matín 200g", manufacturer: "Dr. Schär AG", col1: 0, col2: 2, col3: 0, col4: 0, col5: 0, foodGroups: "pečivo", whereToBuy: ""),
        ]
    }
    
    public func processCode(givenCode: String) -> [String] {
        var resultMessages: [String] = []

        guard let rowNumber = findRowNumber(for: givenCode) else {
            resultMessages.append("Čárový kód \(givenCode) nebyl nalezen v tabulce.")
            return resultMessages
        }

        // Vynulujeme pole před každým vyhodnocením
        resultMessages = []
        
        let columnsToCheck: [String] = ["col1", "col2", "col3", "col4", "col5"]
        
        var validValueFound = false
        
        for column in columnsToCheck {
            if let value = getValue(for: rowNumber, column: column) {
                switch column {
                case "col1":
                    if value == 1 {
                        resultMessages.append("Potravina označena obrázkem jako bezlepková.")
                        validValueFound = true
                    }
                case "col2":
                    if value == 2 {
                        resultMessages.append("Potravina označena obrázkem jako bezlepková")
                        validValueFound = true
                    }
                case "col3":
                    if value == 3 {
                        resultMessages.append("Potravina neoznačena textem ani obrázkem. Není bezlepkové")
                        validValueFound = true
                    }
                case "col4":
                    if value == 4 {
                        resultMessages.append("Potravina neoznačena textem ani obrázkem; je bezlepková.")
                        validValueFound = true
                    }
                case "col5":
                    if value == 5 {
                        resultMessages.append("Nejíst obsahuje lepek.")
                        validValueFound = true
                    }
                default:
                    resultMessages.append("Hodnota v buňce \(column) rádku \(rowNumber + 1): \(value).")
                }
            }
        }
        
        if !validValueFound {
            resultMessages.append("Žádná platná hodnota nalezena pro zadaný kód.")
        }
        
        return resultMessages
    }
    
    private func findRowNumber(for givenCode: String) -> Int? {
        // Odstranění mezer z čárového kódu
        let cleanedCode = givenCode.replacingOccurrences(of: " ", with: "")
        
        // Hledání indexu podle čárového kódu
        guard let index = products.firstIndex(where: { $0.ean == cleanedCode }) else {
            print("Kód nenalezen v tabulce.")
            return nil
        }
        return index
    }
    
    private func getValue(for row: Int, column: String) -> Int? {
        switch column {
        case "col1": return products[row].col1
        case "col2": return products[row].col2
        case "col3": return products[row].col3
        case "col4": return products[row].col4
        case "col5": return products[row].col5
        default: return nil
        }
    }
}
