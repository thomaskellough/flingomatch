//
//  StudyViewController.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class StudyViewController: UICollectionViewController {
    
    var words = [String]()
    weak var delegate: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // possible addition to create custom decks
        // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addWords))
        
        collectionView.backgroundColor = delegate.currentLanguage.colorSecondary
        
        loadWordsToList()
    }
    
    func loadWordsToList() {
        words.removeAll()
        guard let pairs = delegate.currentLanguage.pairs else { return }
        for pair in pairs {
            guard let wordOne = pair.wordOne else { return }
            guard let wordTwo = pair.wordTwo else { return }
            words.append(wordOne)
            words.append(wordTwo)
        }
    }
    
    //    Possible addition to create/edit custom decks
    //    @objc func addWords() {
    //        let ac = UIAlertController(title: "New words?", message: "Add two new words now!", preferredStyle: .alert)
    //        ac.addTextField()
    //        ac.addTextField()
    //        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    //        ac.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak ac] _ in
    //            guard let wordOne = ac?.textFields?[0].text else { return }
    //            guard let wordTwo = ac?.textFields?[1].text else { return }
    //
    //            let pair = Pair(wordOne: wordOne, wordTwo: wordTwo)
    //            pairs.append(pair)
    //            DispatchQueue.main.async {
    //                self?.loadWordsToList()
    //                self?.collectionView.reloadData()
    //            }
    //            }))
    //        present(ac, animated: true)
    //    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Failed to deque cells")
        }
        
        cell.label.adjustsFontSizeToFitWidth = true
        cell.label.backgroundColor = delegate.currentLanguage.colorPrimary
        cell.label.font = UIFont.preferredFont(forTextStyle: .body)
        cell.label.numberOfLines = 0
        cell.label.text = words[indexPath.row]
        cell.label.textAlignment = .center
        cell.label.textColor = delegate.currentLanguage.colorSecondary
        
        cell.layer.backgroundColor = delegate.currentLanguage.colorPrimary?.cgColor
        cell.layer.borderColor = delegate.currentLanguage.colorTertiary?.cgColor
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        
        return cell
    }
}
