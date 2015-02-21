//
//  DataSummary.swift
//  BeeSmarter
//
//  Created by Daniel Galvez on 2/21/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//

import Foundation



class KeySummary {
    let timeDiffRange : (Double, Double)
    let x_pos1Range : (Double, Double)
    let x_pos2Range : (Double, Double)
    let y_pos1Range : (Double, Double)
    let y_pos2Range : (Double, Double)
    let key : String
    init(data:[DataInput])  {
        key = data[0].key
        let times = data.map {Double($0.time)}
        timeDiffRange = calcRange(times)
        x_pos1Range = calcRange(data.map {Double($0.x_pos1)})
        x_pos2Range = calcRange(data.map {Double($0.x_pos2)})
        y_pos1Range = calcRange(data.map {Double($0.y_pos1)})
        y_pos2Range = calcRange(data.map {Double($0.y_pos2)})
    }
}

// https://gist.github.com/jonelf/9ae2a2133e21e255e692
// Google a baratod.
func calcRange(arr : [Double]) -> (Double, Double)
{
    let length = Double(arr.count)
    let avg = arr.reduce(0, {$0 + $1}) / length
    let sumOfSquaredAvgDiff = arr.map { pow($0 - avg, 2.0)}.reduce(0, {$0 + $1})
    let std = sqrt(sumOfSquaredAvgDiff / length)
    return (avg - 3*std, avg + 3*std)
}