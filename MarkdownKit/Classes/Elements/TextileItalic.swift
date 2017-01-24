//
//  TextileItalic.swift
//  Pods
//
//  Created by Tom Kraina on 24/01/2017.
//
//

import UIKit

/// Textile emphasized and italic text parser, more info: [https://txstyle.org/doc/17/emphasized-and-italic-text](https://txstyle.org/doc/17/emphasized-and-italic-text)
public class TextileItalic: MarkdownCommonElement {
    
    private static let regex = "(\\s+|^)(__|_)(.+?)(\\2)"
    
    public var font: UIFont?
    public var color: UIColor?
    
    public var regex: String {
        return TextileItalic.regex
    }
    
    public init(font: UIFont? = nil, color: UIColor? = nil) {
        self.font = font?.italic()
        self.color = color
    }
    
}
