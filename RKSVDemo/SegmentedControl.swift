//
//  SegmentedControl.swift
//  RKSVDemo
//
//  Created by Nikhil Manapure on 22/02/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

@IBDesignable class SegmentedControl: UISegmentedControl {
    
    override func draw(_ rect: CGRect) {
        removeBorders()
    }
    
    func removeBorders() {
        setBackgroundImage(UIImage.withColor(color: backgroundColor ?? UIColor.clear), for: .normal, barMetrics: .default)
        setBackgroundImage(UIImage.withColor(color: tintColor ?? UIColor.ourColor), for: .selected, barMetrics: .default)
        setDividerImage(UIImage.withColor(color: UIColor.clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
}

