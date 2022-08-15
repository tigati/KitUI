import Foundation
import UIKit

public final class MultilineTextFieldView: UITextView, IComponent {
	
	public init() {
		super.init(frame: .zero, textContainer: nil)
		setup()
		backgroundColor = .clear
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	var props: Props = .initial
	
	let placeholderLabel = UILabel()
	
	func setup() {
		isUserInteractionEnabled = false
		delegate = self
		isScrollEnabled = false
		textContainer.lineFragmentPadding = 0
		textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
		
		addSubview(placeholderLabel)
	}
	
	public func render(props: MultilineTextField) {
		defer { self.props = props }
		
		textAlignment = props.style.textAlignment
		tintColor = props.style.cursorColor
		textColor = props.style.textColor
		font = props.style.text.font
		
		
		text = props.text
		
		updatePlaceholder()
		
		let oldProps = self.props
		switch (oldProps.state, props.state) {
		case (.blured, .focused):
			isUserInteractionEnabled = true
			if !isFirstResponder {
				becomeFirstResponder()
			}
			let endPosition = endOfDocument
			selectedTextRange = textRange(from: endPosition, to: endPosition)
		case (.focused, .blured):
			if isFirstResponder {
				resignFirstResponder()
			}
			isUserInteractionEnabled = false
		default:
			break
		}
	}
	
	private func updatePlaceholder() {
		if text.isEmpty {
			placeholderLabel.isHidden = false
		} else {
			placeholderLabel.isHidden = true
		}
		
		placeholderLabel.text = "Test"
		placeholderLabel.sizeToFit()
		placeholderLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: placeholderLabel.bounds.height)
	}
}

extension MultilineTextFieldView: UITextViewDelegate {
	public func textViewDidBeginEditing(_ textView: UITextView) {
		if case let .blured(blured) = props.state {
			blured.onTap.perform()
		}
	}
	
	public func textViewDidChange(_ textView: UITextView) {
		if case let .focused(focused) = props.state {
			focused.onUpdate.perform(with: textView.text)
		}
	}
	
	public func textViewDidEndEditing(_ textView: UITextView) {
		if case let .focused(focused) = props.state {
			focused.onFinishEditing.perform()
		}
	}
}
