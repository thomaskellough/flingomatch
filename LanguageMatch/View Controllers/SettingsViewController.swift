//
//  SettingsViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

extension UIViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

extension UIViewController {
    public func addActivityViewControllerForiPad(activityController: UIActivityViewController) {
        if let popoverPresentationController = activityController.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}

class SettingsViewController: UITableViewController, Storyboarded {
    
    
    weak var coordinator: SettingsCoordinator?
    weak var delegate: ViewController!
    
    var settingsList = ["Default Language", "Tell a Friend!", "Write a Review!", "Hard Mode", "Acknowledgements"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = delegate.currentLanguage.colorSecondary
        cell.layer.cornerRadius = 5
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        cell.textLabel?.text = settingsList[indexPath.row]
        cell.textLabel?.textColor = delegate.currentLanguage.colorPrimary
        
        if cell.textLabel?.text == "Hard Mode" {
            let switchView = UISwitch(frame: .zero)
            let switchBool = UserDefaults.standard.bool(forKey: "switchState")
            switchView.setOn(switchBool, animated: true)
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
            cell.accessoryView = switchView
        }
        
        return cell
    }
    
    @objc func switchChanged(_ sender: UISwitch!) {
        UserDefaults.standard.set(sender.isOn, forKey: "switchState")
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "switchState")
        } else {
            UserDefaults.standard.set(false, forKey: "switchState")
        }
        
        delegate.updateHardMode()
    }
    
    func save(language: String) {
        let defaults = UserDefaults.standard
        defaults.set(language, forKey: "language")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            defaultLanguagesTapped()
        case 1:
            shareAppTapped()
        case 2:
            writeReviewTapped()
        case 4:
            acknowledgementsTapped()
        default:
            break
        }
        
    }
    
    func acknowledgementsTapped() {
        coordinator?.showAcknowledgements()
    }
    
    func defaultLanguagesTapped() {
        let vc = LanguageSelectViewController()
        let languages = vc.getLanguages()
        
        let ac = UIAlertController(title: "Pick a language", message: nil, preferredStyle: .actionSheet)
        for language in languages {
            ac.addAction(UIAlertAction(title: language, style: .default, handler: { [unowned self] _ in
                self.delegate.updateCurrentLanguage(language: language)
                self.save(language: language)
                self.tableView.reloadData()
            }))
        }
        ac.addActionSheetForiPad(actionSheet: ac)
        present(ac, animated: true)
    }
    
    
    func shareAppTapped() {
        let textToShare = "Try this fun new game!"
        let appLink = "https://apps.apple.com/us/app/apple-store/id1476093861"
        let objectToShare = [textToShare, appLink]
        
        let vc = UIActivityViewController(activityItems: objectToShare, applicationActivities: [])
        vc.addActivityViewControllerForiPad(activityController: vc)
        present(vc, animated: true)
    }
    
    func writeReviewTapped() {
        if let url = URL(string: "https://apps.apple.com/us/app/apple-store/id1476093861") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                if UIApplication.shared.canOpenURL(url as URL) {
                    UIApplication.shared.openURL(url as URL)
                }
            }
        }
    }
    
}