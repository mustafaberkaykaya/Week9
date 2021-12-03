//
//  SettingsViewController.swift
//  Week9
//
//  Created by Mustafa Berkay Kaya on 2.12.2021.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController {

    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var languageField: UITextField!
    @IBOutlet private weak var nameText: UITextField!
    @IBOutlet private weak var surnameText: UITextField!
    @IBOutlet private weak var locationSwitch: UISwitch!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var surnameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
   
    let locationManager = CLLocationManager()
    var picker = UIPickerView()
    let languages = [("English", "en"), ("Turkish", "tr"), ("Spanish", "es")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        setupPicker()
        changeLanguage(str: "en")
        
        profileImage.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        profileImage.addGestureRecognizer(imageTapRecognizer)
       
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        
        nameText.text = "Alihan"
        surnameText.text = "Aktay"
        
    }
    
    @objc
    func selectImage() {
        let alert = UIAlertController(title: "To set a profile picture", message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Take a new photo with camera", style: UIAlertAction.Style.default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Choose a photo from gallery", style: UIAlertAction.Style.default, handler: { _ in
            self.openGallery()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: {_ in
            print("cık")
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func openGallery() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func setupPicker() {
        self.picker.backgroundColor = .gray
        self.picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: self.view.frame.width, height: 150))
        self.picker.delegate = self
        self.picker.dataSource = self
        self.languageField.inputView = self.picker
    }
    
    func changeLanguage(str: String) {
        nameLabel.text = "Name".addLocalizableString(str: str)
        surnameLabel.text = "Surname".addLocalizableString(str: str)
        locationLabel.text = "Location".addLocalizableString(str: str)
    }
    
    @IBAction private func locationPerm(_ sender: UISwitch) {
        if sender.isOn == true {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied {
            locationSwitch.isOn = false
        } else if manager.authorizationStatus == .authorizedWhenInUse {
            locationSwitch.isOn = true
        } else if manager.authorizationStatus == .authorizedAlways {
            locationSwitch.isOn = true
        }
    }
}

extension SettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.languages[row].0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.languageField.resignFirstResponder()
        self.languageField.text = self.languages[row].1
        print(languages[row].1)
        changeLanguage(str: languages[row].1)
    }
}

extension String {
    func addLocalizableString(str: String) -> String {
        let path = Bundle.main.path(forResource: str, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
