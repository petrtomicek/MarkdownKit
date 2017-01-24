//
//  TextileBold.swift
//  Pods
//
//  Created by Tom Kraina on 24/01/2017.
//
//

import UIKit


/// Textile strong and bold text parser, more info: [https://txstyle.org/doc/16/strong-and-bold-text](https://txstyle.org/doc/16/strong-and-bold-text)  
public class TextileBold: MarkdownCommonElement {
    
    private static let regex = "(\\s+|^)(\\*\\*|\\*)(.+?)(\\2)"
    
    public var font: UIFont?
    public var color: UIColor?
    
    public var regex: String {
        return TextileBold.regex
    }
    
    public init(font: UIFont? = nil, color: UIColor? = nil) {
        self.font = font?.bold()
        self.color = color
    }
    
}
