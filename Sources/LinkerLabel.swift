
import UIKit

public protocol LinkerLabelDelegate {
  func didTapLink(_ text: String)
}

@IBDesignable
open class LinkerLabel: UILabel {
  
  // MARK: - Types
  
  public enum LinkType {
    case url
    case email
    case time
    case custom(String)

    var regex: String {
      switch self {
      case .url:
        return "(?i)https?://(?:www\\.)?\\S+(?:/|\\b)"
      case .email:
        return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
      case .time:
        return "[0-9]+:[0-9]+"
      case .custom(let customPattern):
        return customPattern
      }
    }
  }
  
  struct LinkTextPosition {
    var frame: CGRect
    var text: String
  }
  
  
  // MARK: - Properties
  
  open var delegate: LinkerLabelDelegate?
  let linkAttributes: [NSAttributedStringKey: Any] = [
    .foregroundColor: UIColor.blue,
    .underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
    .underlineColor: UIColor.blue,
  ]
  private var attributedString: NSMutableAttributedString?
  private var linkTextPositions = [LinkTextPosition]()
  private var linkType: LinkType?
  
  
  // MARK: - Initializers
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    setup()
  }
  
  
  // MARK: - Setups
  
  private func setup() {
    setupView()
    setupGesture()
  }
  
  private func setupView() {
    isUserInteractionEnabled = true
  }
  
  private func setupGesture() {
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLink(_:)))
    addGestureRecognizer(tapGestureRecognizer)
  }
  
  
  // MARK: - Methods
  
  open func decorateLink(_ type: LinkType) {
    self.linkType = type
    guard let text = text else { return }
    
    do {
      let pattern = type.regex
      let regex = try NSRegularExpression(pattern: pattern)
      let matches = regex.matches(in: text, range: text.fullRange)
      matches.forEach { match in
        let range = match.range
        
        appendLinkPosition(range)
        
        attributedString = NSMutableAttributedString(string: text)
        attributedString?.addAttributes(linkAttributes, range: range)
        self.attributedText = attributedString
      }
    } catch {
      print("Log: wrong regex pattern")
    }
  }
  
  private func appendLinkPosition(_ range: NSRange) {
    guard let text = text else { return }
    guard let subTextRange = Range(range, in: text) else { return }
    let subText = text[subTextRange].description
            
    if let textRect = getSubTextRect(range) {
      linkTextPositions.append(.init(frame: textRect, text: subText))
    }
  }
  
  private func getSubTextRect(_ range: NSRange) -> CGRect? {
    guard let attributedText = attributedText else { return nil }
    
    let layoutManager = NSLayoutManager()
    let textStorage = NSTextStorage(attributedString: attributedText)
    textStorage.addLayoutManager(layoutManager)
    
    let textContainer = NSTextContainer(size: intrinsicContentSize)
    textContainer.lineFragmentPadding = 0
    layoutManager.addTextContainer(textContainer)
    
    var glyphRange = NSRange()
    layoutManager.characterRange(
      forGlyphRange: range,
      actualGlyphRange: &glyphRange
    )
    
    let bound = layoutManager.boundingRect(
      forGlyphRange: glyphRange,
      in: textContainer
    )

    return bound
  }
  
  @objc
  private func didTapLink(_ sender: UITapGestureRecognizer) {
    let tapPoint = sender.location(in: self)
    
    for linkPosition in linkTextPositions {
      if tapPoint.isInBound(linkPosition.frame) {
        delegate?.didTapLink(linkPosition.text)
        break
      }
    }
  }
}

private extension String {
  var fullRange: NSRange {
    return NSMakeRange(0, self.count)
  }
}

private extension CGPoint {
  func isInBound(_ rect: CGRect) -> Bool {
    if rect.origin.x <= x && (rect.origin.x + rect.width) >= x &&
        rect.origin.y <= y && (rect.origin.y + rect.height) >= y {
      return true
    }
    return false
  }
}
