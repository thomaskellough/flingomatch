//
//  Flags.swift
//  LanguageMatch
//
//  Created by Thomas Kellough on 8/2/19.
//  Copyright © 2019 Thomas Kellough. All rights reserved.
//

import UIKit

class Flags {
    
    func renderFlag(language: String) -> UIImage? {
        switch language {
        case "French":
            return drawFrenchFlag()
        case "German":
            return drawGermanFlag()
        case "Spanish":
            return drawSpanishFlag()
        case "Italian":
            return drawItalianFlag()
        default:
            return nil
        }
    }
    
    func drawFrenchFlag() -> UIImage {
        let size = getFlagSize()
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let flag = renderer.image { ctx in
            
            let rectangleOne = CGRect(x: 0, y: 0, width: size.width / 3, height: size.height)
            let rectangleTwo = CGRect(x: size.width / 3, y: 0, width: size.width / 3, height: size.height)
            let rectangleThree = CGRect(x: (size.width / 3) * 2, y: 0, width: size.width / 3, height: size.height)
            
            ctx.cgContext.setFillColor(UIColor.French.primary.cgColor)
            ctx.cgContext.addRect(rectangleOne)
            ctx.cgContext.fill(rectangleOne)
            
            ctx.cgContext.setFillColor(UIColor.French.secondary.cgColor)
            ctx.cgContext.addRect(rectangleTwo)
            ctx.cgContext.fill(rectangleTwo)
            
            ctx.cgContext.setFillColor(UIColor.French.tertiary.cgColor)
            ctx.cgContext.addRect(rectangleThree)
            ctx.cgContext.fill(rectangleThree)
        }
        
        return flag
    }
    
    func drawGermanFlag() -> UIImage {
        let size = getFlagSize()
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let flag = renderer.image {ctx in
            let rectangleOne = CGRect(x: 0, y: 0, width: size.width, height: size.height / 3)
            let rectangleTwo = CGRect(x: 0, y: size.height / 3, width: size.width, height: size.height / 3)
            let rectangleThree = CGRect(x: 0, y: (size.height / 3) * 2, width: size.width, height: size.height / 3)
            
            ctx.cgContext.setFillColor(UIColor.German.secondary.cgColor)
            ctx.cgContext.addRect(rectangleOne)
            ctx.cgContext.fill(rectangleOne)
            
            ctx.cgContext.setFillColor(UIColor.German.tertiary.cgColor)
            ctx.cgContext.addRect(rectangleTwo)
            ctx.cgContext.fill(rectangleTwo)
            
            ctx.cgContext.setFillColor(UIColor.German.primary.cgColor)
            ctx.cgContext.addRect(rectangleThree)
            ctx.cgContext.fill(rectangleThree)
        }
        
        return flag
    }
    
    func drawItalianFlag() -> UIImage {
        let size = getFlagSize()
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let flag = renderer.image { ctx in
            
            let rectangleOne = CGRect(x: 0, y: 0, width: size.width / 3, height: size.height)
            let rectangleTwo = CGRect(x: size.width / 3, y: 0, width: size.width / 3, height: size.height)
            let rectangleThree = CGRect(x: (size.width / 3) * 2, y: 0, width: size.width / 3, height: size.height)
            
            ctx.cgContext.setFillColor(UIColor.Italian.primary.cgColor)
            ctx.cgContext.addRect(rectangleOne)
            ctx.cgContext.fill(rectangleOne)
            
            ctx.cgContext.setFillColor(UIColor.Italian.secondary.cgColor)
            ctx.cgContext.addRect(rectangleTwo)
            ctx.cgContext.fill(rectangleTwo)
            
            ctx.cgContext.setFillColor(UIColor.Italian.tertiary.cgColor)
            ctx.cgContext.addRect(rectangleThree)
            ctx.cgContext.fill(rectangleThree)
        }
        
        return flag
    }
    
    func drawSpanishFlag() -> UIImage {
        let size = getFlagSize()
        
        let renderer = UIGraphicsImageRenderer(size: size)
        let flag = renderer.image { ctx in

            let rectangleOne = CGRect(x: 0, y: 0, width: size.width, height: size.height / 4)
            let rectangleTwo = CGRect(x: 0, y: size.height / 4, width: size.width, height: size.height / 2)
            let rectangleThree = CGRect(x: 0, y: (size.height / 4) * 3, width: size.width, height: size.height / 4)
            
            ctx.cgContext.setFillColor(UIColor.Spanish.primary.cgColor)
            ctx.cgContext.addRects([rectangleOne, rectangleThree])
            ctx.cgContext.fill([rectangleOne, rectangleThree])
            
            ctx.cgContext.setFillColor(UIColor.Spanish.tertiary.cgColor)
            ctx.cgContext.addRect(rectangleTwo)
            ctx.cgContext.fill(rectangleTwo)
        }
        
        return flag
    }
    
    func getFlagSize() -> CGSize {
        var size: CGSize
        
        if UIScreen.main.bounds.width < 375 {
            size = CGSize(width: 100, height: 50)
        } else {
            size = CGSize(width: 512, height: 341)
        }
        
        return size
    }
}
