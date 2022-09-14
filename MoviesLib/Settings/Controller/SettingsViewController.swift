//
//  SettingsViewController.swift
//  MoviesLib
//
//  Created by Matheus Lopes on 13/09/22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let userDefault = UserDefaults.standard

    @IBOutlet weak var textFieldCategory: UITextField!
    @IBOutlet weak var switchAutoPlay: UISwitch!
    @IBOutlet weak var segmentedControlColor: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        userDefault.set(textFieldCategory.text, forKey: "category")
        textFieldCategory.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let colorIndex = userDefault.integer(forKey: "color")
        let isAutoPlay = userDefault.bool(forKey: "autoplay")
        let category = userDefault.string(forKey: "category")
        
        segmentedControlColor.selectedSegmentIndex = colorIndex
        switchAutoPlay.setOn(isAutoPlay, animated: true)
        textFieldCategory.text = category
        
    }
    
    @IBAction func changeAutoPlay(_ sender: UISwitch) {
        userDefault.set(sender.isOn, forKey: "autoplay")
    }
    
    @IBAction func changeColor(_ sender: UISegmentedControl) {
        userDefault.set(sender.selectedSegmentIndex, forKey: "color")
    }
}
