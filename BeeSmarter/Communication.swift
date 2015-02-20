//
//  Communication.swift
//  BeeSmarter
//
//  Created by Daniel Galvez on 2/20/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//

import Foundation

func communicate(msg : String, address : String, port : Int) -> String {
    var buffer = stringToBuffer(msg + "\n")
    var inp :NSInputStream?
    var out :NSOutputStream?
    NSStream.getStreamsToHostWithName("localhost", port: 9999, inputStream: &inp, outputStream: &out)
    let inputStream = inp!
    let outputStream = out!
    inputStream.open()
    outputStream.open()
    
    outputStream.write(&buffer, maxLength: buffer.count)

    var inputMessage = ""
    
    while inputStream.hasBytesAvailable {
        var inputBuffer = [UInt8](count : 255, repeatedValue : 0)
        let bytesRead :Int = inputStream.read(&inputBuffer, maxLength: inputBuffer.count)
        let newInput =  NSString(bytes: inputBuffer, length: bytesRead, encoding: NSUTF8StringEncoding) as String
        inputMessage += newInput
    }
    
    var buffer2 = stringToBuffer("TEST3\n")
    outputStream.write(&buffer2, maxLength: buffer2.count)
    
    
    return inputMessage
}

func stringToBuffer(msg: String) -> [UInt8] {
    let data: NSData = msg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
    let stream: NSInputStream = NSInputStream(data: data)
    var buffer = [UInt8](count: data.length, repeatedValue: 0)
    stream.open()
    if stream.hasBytesAvailable {
        let result :Int = stream.read(&buffer, maxLength: buffer.count)
    }
    return buffer
}

func initialize(address : String, port : Int) -> (NSInputStream, NSOutputStream) {
    var inp :NSInputStream?
    var out :NSOutputStream?
    NSStream.getStreamsToHostWithName("localhost", port: 9999, inputStream: &inp, outputStream: &out)
    let inputStream = inp!
    let outputStream = out!
    outputStream.open()
    outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    inputStream.open()
    inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    
    var inputMessage = ""
    //while inputStream.hasBytesAvailable {
    //println("Has bytes")
    var inputBuffer = [UInt8](count : 255, repeatedValue : 0)
    let bytesRead :Int = inputStream.read(&inputBuffer, maxLength: inputBuffer.count)
    let newInput =  NSString(bytes: inputBuffer, length: bytesRead, encoding: NSUTF8StringEncoding) as String
    inputMessage += newInput
    //}


    return (inputStream, outputStream)
    /*
    outputStream.write(&buffer, maxLength: buffer.count)
    
    var inputMessage = ""
    
    while inputStream.hasBytesAvailable {
        var inputBuffer = [UInt8](count : 255, repeatedValue : 0)
        let bytesRead :Int = inputStream.read(&inputBuffer, maxLength: inputBuffer.count)
        let newInput =  NSString(bytes: inputBuffer, length: bytesRead, encoding: NSUTF8StringEncoding) as String
        inputMessage += newInput
    }
    
    var buffer2 = stringToBuffer("TEST3\n")
    outputStream.write(&buffer2, maxLength: buffer2.count)
    
    
    return inputMessage
    */
}

func communicate2(msg: String, outputStream: NSOutputStream, inputStream : NSInputStream) -> String {
    var buffer = stringToBuffer(msg + "\n")
    outputStream.write(&buffer, maxLength: buffer.count)
    
    var inputMessage = ""
    var redo = true
    while redo{
        //println("Has bytes")
        var inputBuffer = [UInt8](count : 255, repeatedValue : 0)
        let bytesRead = inputStream.read(&inputBuffer, maxLength: inputBuffer.count)
        let newInput =  NSString(bytes: inputBuffer, length: bytesRead, encoding: NSUTF8StringEncoding) as String
        inputMessage += newInput
        if bytesRead < 255 {
            redo = false
        }
        
    }
    
    return inputMessage

}

