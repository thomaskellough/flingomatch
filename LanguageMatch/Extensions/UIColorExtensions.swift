//
//  UIColorExtensions.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 6/20/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    struct French {
        static var primary: UIColor {
            UIColor(named: "FrenchPrimary")!
        }
        static var secondary: UIColor {
            UIColor(named: "FrenchSecondary")!
        }
        static var tertiary: UIColor {
            UIColor(named: "FrenchTertiary")!
        }
    }

    struct Italian {
        static var primary: UIColor {
            UIColor(named: "ItalianPrimary")!
        }
        static var secondary: UIColor {
            UIColor(named: "ItalianSecondary")!
        }
        static var tertiary: UIColor {
            UIColor(named: "ItalianTertiary")!
        }
    }

    struct Spanish {
        static var primary: UIColor {
            UIColor(named: "SpanishPrimary")!
        }
        static var secondary: UIColor {
            UIColor(named: "SpanishSecondary")!
        }
        static var tertiary: UIColor {
            UIColor(named: "SpanishTertiary")!
        }
    }
    
    struct German {
        static var primary: UIColor {
            UIColor(named: "GermanPrimary")!
        }
        static var tertiary: UIColor {
            UIColor(named: "GermanSecondary")!
        }
        static var secondary: UIColor {
            UIColor(named: "GermanTertiary")!
        }
    }
}
