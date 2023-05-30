//
//  Fonts.swift
//  Antitasker
//
//  Created by Andrey Chernyshev on 16.01.2021.
//

import UIKit

struct Fonts {
    // MARK: Ubuntu
    struct Ubuntu {
        static func medium(size: CGFloat) -> UIFont {
            UIFont(name: "Ubuntu Medium", size: size)!
        }
        
        static func bold(size: CGFloat) -> UIFont {
            UIFont(name: "Ubuntu-Bold", size: size)!
        }
        
        static func regular(size: CGFloat) -> UIFont {
            UIFont(name: "Ubuntu-Regular", size: size)!
        }
        
        static func light(size: CGFloat) -> UIFont {
            UIFont(name: "Ubuntu-Light", size: size)!
        }
    }
}
