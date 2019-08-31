//
//  SettingsViewController.swift
//  MiAguilaTest
//
//  Created by Ricardo Grajales Duque on 8/30/19.
//  Copyright © 2019 Ricardo Grajales Duque. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet weak var initialLongitudeTextField: UITextField!
    @IBOutlet weak var initialLatitudeTextField: UITextField!
    @IBOutlet weak var finalLongitudeTextField: UITextField!
    @IBOutlet weak var finalLatitudeTextField: UITextField!
    @IBOutlet weak var distanceStepsTextField: UITextField!
    let configurationsViewModel = ConfigurationsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavigationBar()
        setUpConfigurationsData()
    }

    private func setUpConfigurationsData() {
        self.initialLongitudeTextField.text = configurationsViewModel.initialLogitudeString
        self.initialLatitudeTextField.text = configurationsViewModel.initialLatitudeString
        self.finalLongitudeTextField.text = configurationsViewModel.finalLogitudeString
        self.finalLatitudeTextField.text = configurationsViewModel.finalLatitudeString
        self.distanceStepsTextField.text = configurationsViewModel.distanceStepsString
    }
    
    private func setUpNavigationBar() {
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveAction))
    }
    
    @objc func saveAction() {
        do {
            let data = prepareData()
            try configurationsViewModel.updateConfigurations(data: data)
            navigationController?.popViewController(animated: true)
        }
        catch {
            //error alert
            print("**** ERROR *****")
        }
    }
    
    private func prepareData() -> [AnyHashable: String] {
        var data = [AnyHashable: String]()
        data[DictionaryKeys.initialLongitude] = self.initialLongitudeTextField.text
        data[DictionaryKeys.initialLatitude] = self.initialLatitudeTextField.text
        data[DictionaryKeys.finalLongitude] = self.finalLongitudeTextField.text
        data[DictionaryKeys.finalLatitude] = self.finalLatitudeTextField.text
        data[DictionaryKeys.distanceSteps] = self.distanceStepsTextField.text

        return data
    }
}

private extension SettingsViewController {
    struct DictionaryKeys {
        static let initialLongitude = "initialLongitude"
        static let initialLatitude = "initialLatitude"
        static let finalLongitude = "finalLongitude"
        static let finalLatitude = "finalLatitude"
        static let distanceSteps = "distanceSteps"
    }
}
