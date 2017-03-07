//
//  TextileParser.swift
//  Pods
//
//  Created by Tom Kraina on 24/01/2017.
//
//

import Foundation

public class TextileParser {
    
    // MARK: Element Arrays
    private var escapingElements: [MarkdownElement]
    private var defaultElements: [MarkdownElement]
    private var unescapingElements: [MarkdownElement]
    
    public var customElements: [MarkdownElement]
    
    public let link: TextileLink
    public let automaticLink: MarkdownAutomaticLink
    public let bold: TextileBold
    public let italic: TextileItalic
    
    // MARK: Escaping Elements
    private var codeEscaping = MarkdownCodeEscaping()
    private var escaping = MarkdownEscaping()
    private var unescaping = MarkdownUnescaping()
    
    // MARK: Configuration
    /// Enables or disables detection of URLs even without Markdown format
    public var automaticLinkDetectionEnabled: Bool = true
    public let font: UIFont
    
    // MARK: Initializer
    public init(font: UIFont = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize),
                automaticLinkDetectionEnabled: Bool = true,
                customElements: [MarkdownElement] = []) {
        self.font = font
        
        link = TextileLink(font: font)
        automaticLink = MarkdownAutomaticLink(font: font)
        bold = TextileBold(font: font)
        italic = TextileItalic(font: font)
        
        self.automaticLinkDetectionEnabled = automaticLinkDetectionEnabled
        self.escapingElements = [codeEscaping, escaping]
        self.defaultElements = [link, automaticLink, bold, italic]
        self.unescapingElements = [unescaping]
        self.customElements = customElements
    }
    
    // MARK: Element Extensibility
    public func addCustomElement(element: MarkdownElement) {
        customElements.append(element)
    }
    
    public func removeCustomElement(element: MarkdownElement) {
        guard let index = customElements.index(where: { someElement -> Bool in
            return element === someElement
        }) else {
            return
        }
        customElements.remove(at: index)
    }
    
    // MARK: Parsing
    public func parse(markdown: String) -> NSAttributedString {
        return parse(markdown: NSAttributedString(string: markdown))
    }
    
    public func parse(markdown: NSAttributedString) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(attributedString: markdown)
        attributedString.addAttribute(NSFontAttributeName, value: font,
                                      range: NSRange(location: 0, length: attributedString.length))
        var elements: [MarkdownElement] = escapingElements
        elements.append(contentsOf: defaultElements)
        elements.append(contentsOf: customElements)
        elements.append(contentsOf: unescapingElements)
        elements.forEach { element in
            if automaticLinkDetectionEnabled || type(of: element) != MarkdownAutomaticLink.self {
                element.parse(attributedString)
            }
        }
        return attributedString
    }
    
}
