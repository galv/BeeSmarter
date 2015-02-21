//
//  DataSummary.swift
//  BeeSmarter
//
//  Created by Daniel Galvez on 2/21/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//

import Foundation

class DataSummary {
    
    var keySummaries : [KeySummary] = []

    
    init(dataPoints :[[DataInput]]) {
        var tmp : [DataInput] = []
        
        for j in 0..<countElements(dataPoints[0]) {
            for i in 0..<countElements(dataPoints) {
                tmp.append(dataPoints[i][j])
            }
            keySummaries.append(KeySummary(data: tmp))
            tmp.removeAll(keepCapacity: false)
        }
    }
    
    func isCorrect(input: [DataInput]) -> Bool {
        let mistakeCount = eval(input)
        
        if mistakeCount == -1 {
            return false
        } else if Double(mistakeCount) / Double(countElements(input) as NSNumber) > 0.3 {
            return false
        } else {
            return true
            }
        }
    
    
    func eval(input : [DataInput]) -> Int {
        var counter = 0
        for i in 0..<input.count {
            if input[i].key != keySummaries[i].key {
                return -1
            }
            if Double(input[i].time) < keySummaries[i].timeDiffRange.0 || Double(input[i].time) > keySummaries[i].timeDiffRange.1{
                counter++
            }
            if Double(input[i].x_pos1) < keySummaries[i].x_pos1Range.0 || Double(input[i].x_pos1) > keySummaries[i].x_pos1Range.1{
                counter++
            }
            if Double(input[i].x_pos2) < keySummaries[i].x_pos2Range.0 || Double(input[i].x_pos2) > keySummaries[i].x_pos2Range.1{
                counter++
            }
            if Double(input[i].y_pos1) < keySummaries[i].y_pos1Range.0 || Double(input[i].y_pos1) > keySummaries[i].y_pos1Range.1{
                counter++
            }
            if Double(input[i].y_pos2) < keySummaries[i].y_pos2Range.0 || Double(input[i].y_pos2) > keySummaries[i].y_pos2Range.1{
                counter++
            }

        }
        return counter
    }
}
