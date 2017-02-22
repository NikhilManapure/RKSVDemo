//
//  StockPoint.swift
//  RKSVDemo
//
//  Created by Nikhil Manapure on 22/02/17.
//  Copyright © 2017 Nikhil Manapure. All rights reserved.
//

import UIKit

// Modal Class
class StockPoint {
    var timestamp : Date?
    var open : Float?
    var high : Float?
    var low : Float?
    var close : Float?
    var volume : Int?
    
    static func modal(fromString str : String) -> StockPoint? {
        let modal = StockPoint()
        
        let array = str.components(separatedBy: ",")
        if array.count < 6 {
            return nil
        }
        
        modal.timestamp = Date(timeIntervalSince1970: TimeInterval(array[0])!)
        modal.open = Float(array[1])
        modal.high = Float(array[2])
        modal.low = Float(array[3])
        modal.close = Float(array[4])
        modal.volume = Int(array[5])
        return modal
    }
}
