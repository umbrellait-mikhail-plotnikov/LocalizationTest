//
//  LanguageProvider.swift
//  LocalizationTest
//
//  Created by Mikhail Plotnikov on 16.04.2021.
//
import UIKit
import Foundation

final class LanguageProvider {
    static let shared = LanguageProvider()
    private let languageBundle = "LanguageBundlePath"
    
    var languageArray: [String] {
        return ["", "En", "Ru", "🤨"]
    }
    
    func getPathToBundle() -> String? {
        return UserDefaults.standard.string(forKey: self.languageBundle)
    }
    
    func setPath(toBundle path: String) {
        UserDefaults.standard.setValue(path, forKey: self.languageBundle)
    }
    
    func getLocalizedString(key: String, _ arguments: CVarArg...) -> String {
        
        if let path = LanguageProvider.shared.getPathToBundle(),
           let bundle = Bundle(path: path) {
            let format = NSLocalizedString(key, tableName: nil, bundle: bundle, comment: "")
            if arguments.count == 2 {
                return String.localizedStringWithFormat(format, arguments[0], arguments[1])
            }
            if arguments.count == 1 {
                return String.localizedStringWithFormat(format, arguments[0])
            } else {
                return String.localizedStringWithFormat(format)
            }
        } else {
            let format = NSLocalizedString(key, comment: "")
            return String.localizedStringWithFormat(format)
        }
    }
}

