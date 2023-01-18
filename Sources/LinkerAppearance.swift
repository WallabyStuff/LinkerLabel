//
//  LinkerAppearance.swift
//  LinkerLabel
//
//  Created by Wallaby on 2023/01/17.
//

import UIKit

open class LinkerAppearance {
  
  // MARK: - Properties
  
  open var foregroundColor = UIColor.systemBlue
  open var backgroundColor = UIColor.clear
  open var underlineColor = UIColor.systemBlue
  open var isUnderlined = true
  open var isItalic = false
  open var font: UIFont?
  
  
  // MARK: - Initializers
  
  public init() { }
  
  
  // MARK: - Methods
  
  internal func allAttributes() -> [[NSAttributedString.Key: Any]] {
    var attributes = [[NSAttributedString.Key: Any]]()
    
    let defaultAttributes: [NSAttributedString.Key: Any] = [
      .foregroundColor: foregroundColor,
      .backgroundColor: backgroundColor
    ]
    attributes.append(defaultAttributes)
    
    if isUnderlined {
      let underlineAttribute: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
        .underlineColor: underlineColor
      ]
      attributes.append(underlineAttribute)
    }
    
    if let font = font {
      let fontAttribute: [NSAttributedString.Key: Any] = [
        .font: font
      ]
      attributes.append(fontAttribute)
    }
    
    return attributes
  }
}
