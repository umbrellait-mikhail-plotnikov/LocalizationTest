//
//  LocalizationScreen.swift
//  LocalizationTest
//
//  Created by Mikhail Plotnikov on 20.04.2021.
//

import UIKit

class LocalizationScreen: UIViewController {
    
    @IBOutlet weak var zeroBananaLabel: UILabel!
    @IBOutlet weak var oneBananaLabel: UILabel!
    @IBOutlet weak var twoBananaLabel: UILabel!
    @IBOutlet weak var fewBananaLabel: UILabel!
    @IBOutlet weak var manyBananaLabel: UILabel!
    
    
    @IBOutlet weak var zeroDmgPerMomentLabel: UILabel!
    @IBOutlet weak var oneDmgPerSecondLabel: UILabel!
    @IBOutlet weak var manyDmgPerManyTimeLabel: UILabel!
    
    private let localizationProvider = LanguageProvider.shared
    
    private func updateLabelText() {
        zeroBananaLabel.text = localizationProvider.getLocalizedString(key: "bananas", 0)
        oneBananaLabel.text = localizationProvider.getLocalizedString(key: "bananas", 1)
        twoBananaLabel.text = localizationProvider.getLocalizedString(key: "bananas", 2)
        fewBananaLabel.text = localizationProvider.getLocalizedString(key: "bananas", 4)
        manyBananaLabel.text = localizationProvider.getLocalizedString(key: "bananas", 25)
        
        zeroDmgPerMomentLabel.text = localizationProvider.getLocalizedString(key: "dmg_per_time", 0, 0)
        oneDmgPerSecondLabel.text = localizationProvider.getLocalizedString(key: "dmg_per_time", 1, 1)
        manyDmgPerManyTimeLabel.text = localizationProvider.getLocalizedString(key: "dmg_per_time", 5, 7)
    }
    
    @IBAction func changeLanguageButtonPress(_ sender: Any) {
        guard let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "LanguageChange") else { return }
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notify), name: NSNotification.Name(rawValue: "LanguageChange"), object: nil)
        
        updateLabelText()
    }
    
    @objc
    private func notify() {
        updateLabelText()
        
    }
}
