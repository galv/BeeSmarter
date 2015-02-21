//
//  DataInput.swift
//  BeeSmarter
//
//  Created by Daniel Galvez on 2/21/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//

import Foundation

var dataPoints = [[DataInput]](count: 0, repeatedValue: [])

class DataInput {
    
    let time : Int
    let key : String
    let x_pos1 : Int
    let x_pos2 : Int
    let y_pos1 : Int
    let y_pos2 : Int
    let finalTime : Int
    
    init(time : Int, key : String, x_pos1 : Int, x_pos2 : Int, y_pos1 : Int, y_pos2 : Int, finalTime : Int) {
        self.time = time
        self.key = key
        self.x_pos1 = x_pos1
        self.x_pos2 = x_pos2
        self.y_pos1 = y_pos1
        self.y_pos2 = y_pos2
        self.finalTime = finalTime
    }
}
