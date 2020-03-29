//
//  Country.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 3/28/20.
//  Copyright © 2020 Thomas Kellough. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    struct French {
        static var primary: UIColor {
            return UIColor(red: 0, green: 85/255, blue: 164/255, alpha: 1)
        }
        static var secondary: UIColor {
            return UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        }
        static var tertiary: UIColor {
            return UIColor(red: 239/255, green: 65/255, blue: 63/255, alpha: 1)
        }
    }

    struct Italian {
        static var primary: UIColor {
            return UIColor(red: 0, green: 140/255, blue: 69/255, alpha: 1)
        }
        static var secondary: UIColor {
            return UIColor(red: 244/255, green: 245/255, blue: 240/255, alpha: 1)
        }
        static var tertiary: UIColor {
            return UIColor(red: 205/255, green: 33/255, blue: 42/255, alpha: 1)
        }
    }

    struct Spanish {
        static var primary: UIColor {
            return UIColor(red: 170/255, green: 21/255, blue: 27/255, alpha: 1)
        }
        static var secondary: UIColor {
            return UIColor.white
        }
        static var tertiary: UIColor {
            return UIColor(red: 241/255, green: 191/255, blue: 0, alpha: 1)
        }
    }
}

struct Language {
    var name: String
    var flag: UIImage
    var colorPrimary: UIColor?
    var colorSecondary: UIColor?
    var colorTertiary: UIColor?
    
    init(name: String) {
        self.name = name
        self.flag = Flags().renderFlag(language: name)
        
        self.setColors(name: name)
    }
    
    mutating func setColors(name: String) {
        switch name {
        case "French":
            self.colorPrimary = UIColor.French.primary
            self.colorSecondary = UIColor.French.secondary
            self.colorTertiary = UIColor.French.tertiary
        case "Italian":
            self.colorPrimary = UIColor.Italian.primary
            self.colorSecondary = UIColor.Italian.secondary
            self.colorTertiary = UIColor.Italian.tertiary
        case "Spanish":
            self.colorPrimary = UIColor.Spanish.primary
            self.colorSecondary = UIColor.Spanish.secondary
            self.colorTertiary = UIColor.Spanish.tertiary
        default:
            self.colorPrimary = UIColor.white
            self.colorSecondary = UIColor.white
            self.colorTertiary = UIColor.white
        }
    }
}

