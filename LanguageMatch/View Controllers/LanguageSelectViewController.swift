//
//  LanguageSelectViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class LanguageSelectViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    
    var languages: [String] = []
    var flags: Flags!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        flags = Flags()
        languages = getLanguages()
        
        tableView.rowHeight = 80
        view.backgroundColor = ViewController.currentLanguage.colorSecondary
    }
    
    func getLanguages() -> [String] {
        // Create tests to verify languages are the correct amount
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            
            return items.filter { $0.hasSuffix(".txt") }.compactMap { $0.replacingOccurrences(of: ".txt", with: "") }
        } catch {
            fatalError("Could not load any languages!")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let language = languages[indexPath.row]
        let image = flags.renderFlag(language: language)
        
        if ViewController.currentLanguage.name == language {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        cell.backgroundColor = ViewController.currentLanguage.colorSecondary
        cell.layer.cornerRadius = 5
        cell.imageView?.center = cell.center
        cell.imageView?.image = image
        cell.textLabel?.text = language
        cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .title2)
        cell.textLabel?.textColor = ViewController.currentLanguage.colorPrimary
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let language = languages[indexPath.row]
        ViewController.updateCurrentLanguage(language: language)
        view.backgroundColor = ViewController.currentLanguage.colorSecondary
        self.tableView.reloadData()
    }
}
