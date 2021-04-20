//
//  LanguageChangeScreen.swift
//  LocalizationTest
//
//  Created by Mikhail Plotnikov on 20.04.2021.
//

import UIKit

class LanguageChangeScreen: UIViewController {
    
    internal let localizationProvider = LanguageProvider.shared
    
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var headerLabel: UILabel!
    
    @IBAction func changeButtonPress(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        updateLocalizedText()
        changeButton.alpha = 0
        changeButton.isEnabled = false
    }
    
    func updateLocalizedText() {
        headerLabel.text = localizationProvider.getLocalizedString(key: "changeLang")
        changeButton.setTitle(localizationProvider.getLocalizedString(key: "change"), for: .normal)
    }
    
}


extension LanguageChangeScreen: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return localizationProvider.languageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return localizationProvider.languageArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        var lang = localizationProvider.languageArray[row].lowercased()
        if row == 3 { lang = "ak" }
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj") else { fatalError("Unknown language") }
        guard Bundle(path: path) != nil else { fatalError("Doesn't exist localization") }

        localizationProvider.setPath(toBundle: path)
        
        if row != 0 {
            UIView.animate(withDuration: 0.3) {
                self.changeButton.alpha = 1
                self.changeButton.isEnabled = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.changeButton.alpha = 0
                self.changeButton.isEnabled = false
            }
        }
        
        updateLocalizedText()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChange"), object: nil)
    }
}
