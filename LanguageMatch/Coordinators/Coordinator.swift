//
//  Coordinator.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/21/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var children: [Coordinator] { get set }
    func start()
}
