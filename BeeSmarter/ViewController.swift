//
//  ViewController.swift
//  BeeSmarter
//
//  Created by Kevin Gerami on 2/20/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//



import UIKit

class ViewController: UIViewController, NSXMLParserDelegate {

    var numTrainingSamples = 0
    var tmp : [NSObject : AnyObject]!
    var nextCapital : Bool = false

    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        if (elementName == "training") {
            
        }
        println("Element's name is \(elementName)")
        println("Element's attributes are \(attributeDict)")
        
        if elementName == "key-down"
        {
            tmp = attributeDict
        }
        else if elementName == "pattern"
        {
            numTrainingSamples++
            dataPoints.append([])
        }
        else if elementName == "key-up"
        {
            var nf = NSNumberFormatter()
            let key = String(tmp["code"] as NSString)
            
            //let thingy : String = (attributeDict["posix-time"]! as NSString).toInt()

            let timeDiff = Int(nf.numberFromString(attributeDict["posix-time"]! as NSString)!)
                - Int(nf.numberFromString(tmp["posix-time"]! as NSString)!)
            
            let tmpXString =  String(tmp["relative-pos-x"] as NSString)
            let tmpX = tmpXString.substringToIndex(tmpXString.endIndex.predecessor()).toInt()!
            
            let tmpYString = String(tmp["relative-pos-x"] as NSString)
            let tmpY = tmpYString.substringToIndex(tmpYString.endIndex.predecessor()).toInt()!
            
            let dictXString =  String(attributeDict["relative-pos-x"] as NSString)
            let dictX = dictXString.substringToIndex(dictXString.endIndex.predecessor()).toInt()!
            
            let dictYString = String(attributeDict["relative-pos-x"] as NSString)
            let dictY = dictYString.substringToIndex(dictYString.endIndex.predecessor()).toInt()!
            
            let finalTime = Int(nf.numberFromString(attributeDict["posix-time"]! as NSString)!)
            
            let dataIn = DataInput(time: timeDiff, key: key, x_pos1: tmpX, x_pos2: dictX, y_pos1: tmpY, y_pos2: dictY, finalTime: finalTime)
            
            
            dataPoints[numTrainingSamples].append(dataIn)
        }
    }
    
    override func viewDidLoad() {
        //println(communicate("BSP 1.0 CLIENT HELLO", "localhost", 9999))
        //println(communicate("TEST3", "localhost", 9999))
        let (ins, outs) = initialize("localhost", 9999)
        println(communicate2("BSP 1.0 CLIENT HELLO", outs, ins))
        println(communicate2("TEST3", outs, ins))
        
        let password = communicate2("RQSTDATA", outs, ins)
        let training = communicate2("RQSTTRAIN", outs, ins)
        let xml = NSXMLParser(data: training.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        xml.delegate = self//XMLMunger()
        xml.parse()
        
//        let msg = "TEST3"
//        let data: NSData = msg.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!
//        var buffer = [UInt8](count: data.length, repeatedValue: 0)
//        outS.write(&buffer, maxLength: buffer.count)
        //connectWithServer("BSP 1.0 CLIENT HELLO")
        //connectWithServer("test3")
        //connectWithServer("RQSTDATA")
        //connectWithServer("RQSTTRAIN")

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
        //inputStream.read(<#buffer: UnsafeMutablePointer<UInt8>#>, maxLength: <#Int#>)
        
        
    }
    
    
}

