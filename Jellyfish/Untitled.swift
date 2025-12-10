//
//  Untitled.swift
//  Jellyfish
//
//  Created by rand on 17/06/1447 AH.
//
import Foundation

extension String {
    /// يرجّع النص المترجم من ملفات الـ Localizable.strings / .xcstrings
    var localized: String {
        NSLocalizedString(
            self,
            tableName: nil,
            bundle: .main,
            value: self,
            comment: ""
        )
    }
    
    /// لو عندك placehodlers في النص وتبغين تمررين قيم
    /// مثال: "Hello %@".localized("Rand")
    func localized(_ args: CVarArg...) -> String {
        String(format: self.localized, arguments: args)
    }
}
