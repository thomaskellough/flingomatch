//
//  LanguageSelectViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class LanguageSelectViewController: UITableViewController {
    
    weak var mainVC: ViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        view.backgroundColor = mainVC.currentLanguage.colorSecondary
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalLanguages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let language = globalLanguages[indexPath.row]
        let vc = Flags()
        let image = vc.renderFlag(language: language)
        
        cell.backgroundColor = mainVC.currentLanguage.colorSecondary
        cell.layer.cornerRadius = 5
        cell.imageView?.center = cell.center
        cell.imageView?.image = image
        cell.textLabel?.text = language
        cell.textLabel?.font = UIFont(name: globalFont, size: globalFontSize)
        cell.textLabel?.textColor = mainVC.currentLanguage.colorPrimary
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = globalLanguages[indexPath.row]
        mainVC?.updateCurrentLanguage(language: language)
        self.tableView.reloadData()
    }
}
