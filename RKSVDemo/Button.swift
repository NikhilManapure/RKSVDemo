//
//  Button.swift
//  RKSVDemo
//
//  Created by Nikhil Manapure on 22/02/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

@IBDesignable class Button: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 5
        clipsToBounds = true
    }
}
