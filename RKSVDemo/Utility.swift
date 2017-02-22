//
//  Utility.swift
//  RKSVDemo
//
//  Created by Nikhil Manapure on 22/02/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import Foundation
import UIKit

var baseUrlStr = "http://kaboom.rksv.net/api/"
var historicalService = "historical"
var watch = "watch"

extension UIImage {
    static func withColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor);
        context!.fill(rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!
    }
}

extension UIColor {
    static var ourColor : UIColor {
        return UIColor(colorLiteralRed: 69.0/255.0, green: 183.0/255.0, blue: 199.0/255.0, alpha: 1.0)
    }
}
