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
	
	func setup() {
		delegate = self
		isScrollEnabled = false
		textContainer.lineFragmentPadding = 0
		textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
		contentInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
	}
	
	public func render(props: MultilineTextField) {
		defer { self.props = props }
		textAlignment = props.style.textAlignment
		tintColor = props.style.cursorColor
		textColor = props.style.textColor
		font = props.style.text.font
		text = props.text
		
		switch props.state {
		case .blured:
			resignFirstResponder()
		case .focused:
			becomeFirstResponder()
		}
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
