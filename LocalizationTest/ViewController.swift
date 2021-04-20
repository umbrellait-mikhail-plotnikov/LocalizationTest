//
//  ViewController.swift
//  LocalizationTest
//
//  Created by Mikhail Plotnikov on 16.04.2021.
//

import UIKit

class ViewController: UIViewController {

    private let localizationProvider = LanguageProvider.shared
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var chooseYourLangaugeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBAction func buttonTap(_ sender: Any) {
        guard let nextViewController = self.storyboard?.instantiateViewController(identifier: "LocalizationScreen") else { return }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    private func updateLocalizedText() {
        welcomeLabel.text = localizationProvider.getLocalizedString(key: "welcome")
        nextButton.setTitle(localizationProvider.getLocalizedString(key: "letsgo"), for: .normal)
        chooseYourLangaugeLabel.text = localizationProvider.getLocalizedString(key: "chooseLang")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nextButton.isEnabled = false
        nextButton.alpha = 0
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        updateLocalizedText()
    }
    
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        
        updateLocalizedText()
        
        if row != 0 {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 1
                self.nextButton.isEnabled = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 0
                self.nextButton.isEnabled = false
            }
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LanguageChange"), object: nil)
    }
}
