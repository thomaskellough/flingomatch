//
//  UIViewExtensions.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/30/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func removeAllSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
