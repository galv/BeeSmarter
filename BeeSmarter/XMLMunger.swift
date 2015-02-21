//
//  XMLMunger.swift
//  BeeSmarter
//
//  Created by Daniel Galvez on 2/21/15.
//  Copyright (c) 2015 Lamb­da. All rights reserved.
//

import Foundation

class XMLMunger : NSObject, NSXMLParserDelegate {
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: [NSObject : AnyObject]!) {
        println("Element's name is \(elementName)")
        println("Element's attributes are \(attributeDict)")
    }
}