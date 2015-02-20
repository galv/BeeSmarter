//
//  ViewController.swift
//  BeeSmarter
//
//  Created by Kevin Gerami on 2/20/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//



import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        connectWithServer("BSP 1.0 CLIENT HELLO")
        connectWithServer("test3")
        connectWithServer("RQSTDATA")
        connectWithServer("RQSTTRAIN")
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // http://stackoverflow.com/questions/24840297/swift-only-reading-from-nsinputstream/25284703#25284703
    func connectWithServer(msg: String) {
        let data: NSData = msg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
        let stream: NSInputStream = NSInputStream(data: data)
        var buffer = [UInt8](count: data.length, repeatedValue: 0)
        stream.open()
        if stream.hasBytesAvailable {
            let result :Int = stream.read(&buffer, maxLength: buffer.count)
        }
        var inp :NSInputStream?
        var out :NSOutputStream?
        NSStream.getStreamsToHostWithName("localhost", port: 9999, inputStream: &inp, outputStream: &out)
        
        let inputStream = inp!
        let outputStream = out!
        inputStream.open()
        outputStream.open()
        var readByte :UInt8 = 0
        while inputStream.hasBytesAvailable {
            inputStream.read(&readByte, maxLength: 1)
        }
        outputStream.write(&buffer, maxLength: buffer.count)
        inputStream.read(<#buffer: UnsafeMutablePointer<UInt8>#>, maxLength: <#Int#>)
        
        
    }
    
    
}

