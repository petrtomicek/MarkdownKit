//
//  TextileLink.swift
//  Pods
//
//  Created by Tom Kraina on 23/01/2017.
//
//

import Foundation

/// Textile links parser, more info: [https://txstyle.org/doc/12/links](https://txstyle.org/doc/12/links)
public class TextileLink: MarkdownLink {
    
    private static let regex: String = "\"[^\\\"]*\":((https?|ftp):\\/)?\\/(-\\.)?([^\\s\\/?\\.#-]+\\.?)+(\\/[^\\s]*)?"
    
    override public var regex: String {
        return TextileLink.regex
    }
    
    override public func match(_ match: NSTextCheckingResult, attributedString: NSMutableAttributedString) {
        
        let string = attributedString.string as NSString
        let colonLocation = string.range(of: ":", options: [], range: match.range).location
        let linkRange = NSRange(location: colonLocation, length: match.range.length + match.range.location - colonLocation - 1)
        
        let linkURLString = string.substring(with: NSRange(location: linkRange.location + 1, length: linkRange.length))
        
        // deleting trailing markdown
        // needs to be called before formattingBlock to support modification of length
        attributedString.deleteCharacters(in: NSRange(location: linkRange.location - 1, length: linkRange.length + 2))
        
        // deleting parenthesis with class or title info
        var deletedLength = 0
        let titleRange = NSRange(location: match.range.location, length: linkRange.location-match.range.location-1)
        for range in rangesOfParentheses(string: string, inRange: titleRange).reversed() {
            attributedString.deleteCharacters(in: range)
            deletedLength += range.length
        }
        
        // deleting leading markdown
        // needs to be called before formattingBlock to provide a stable range
        attributedString.deleteCharacters(in: NSRange(location: match.range.location, length: 1))
        
        let formatRange = NSRange(location: match.range.location, length: colonLocation - match.range.location - 2 - deletedLength)
        formatText(attributedString, range: formatRange, link: linkURLString)
        addAttributes(attributedString, range: formatRange, link: linkURLString)
    }
    
    
    private func rangesOfParentheses(string: NSString, inRange range: NSRange?) -> [NSRange] {
        
        var starts: [Int] = []
        var ranges: [NSRange] = []
        
        let start: Int
        let end: Int
        
        if let range = range {
            start = range.location
            end = range.location + range.length
        } else {
            start = 0
            end = string.length
        }
        
        for index in start ..< end {
            let char = UnicodeScalar(string.character(at: index))
            
            if char == "(" {
                starts.append(index)
                continue
            }
            
            if char == ")", let start = starts.popLast() {
                let range = NSRange(location: start, length: index - start + 1)
                ranges.append(range)
                continue
            }
        }
        
        return ranges
    }
}

