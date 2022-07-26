import UIKit

public final class TextFieldView: UITextField, IComponent {
	
	private var props: TextField = .initial
	
	// MARK: - Lifecycle
	
	public init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
		bounds
	}
	
	public override func textRect(forBounds bounds: CGRect) -> CGRect {
		bounds
	}
	
	public override func editingRect(forBounds bounds: CGRect) -> CGRect {
		bounds
	}
	
	func setup() {
		isUserInteractionEnabled = false
		addTarget(self, action: #selector(textChanged), for: .editingChanged)
		delegate = self
	}
	
	// MARK: - Public methods
	
	public func render(props: TextField) {
		let oldProps = self.props
		self.props = props
		switch (oldProps.state, props.state) {
		case (.blured, .focused):
			isUserInteractionEnabled = true
			if !isFirstResponder {
				becomeFirstResponder()
			}
		case (.focused, .blured):
			if isFirstResponder {
				resignFirstResponder()
			}
			isUserInteractionEnabled = false
		default:
			break
		}
		
		text = props.text
		
		setTextInputTraits(traits: props.traits, oldTraits: oldProps.traits)
		
		if
			let placeholderText = props.placeholder,
			oldProps.style.placeholder != props.style.placeholder
		{
			let placeholderAttributes = props.style.placeholder.attributes(
				for: textAlignment,
				color: props.style.placeholderColor,
				lineBreakMode: .byWordWrapping
			)
			attributedPlaceholder = NSAttributedString(
				string: placeholderText,
				attributes: placeholderAttributes
			)
		}
		
		textAlignment = props.style.textAlignment
		tintColor = props.style.cursorColor
		font = props.style.text.font
		textColor = props.style.textColor
		
		if oldProps.style != props.style {
			setNeedsLayout()
		}
	}
	
	private func setTextInputTraits(traits: TextInputTraits, oldTraits: TextInputTraits) {
		keyboardType = traits.keyboardType
		keyboardAppearance = traits.keyboardAppearance
		returnKeyType = traits.returnKeyType
		textContentType = traits.textContentType
		autocapitalizationType = traits.autocapitalizationType
		autocorrectionType = traits.autocorrectionType
		spellCheckingType = traits.spellCheckingType
		
		if traits.secureTextEntry != oldTraits.secureTextEntry {
			togglePasswordVisibility()
		}
	}
	
	private func togglePasswordVisibility() {
		isSecureTextEntry = !isSecureTextEntry
		
		if let existingText = text, isSecureTextEntry {
			text = nil
			insertText(existingText)
		}
		if let existingSelectedTextRange = selectedTextRange {
			selectedTextRange = nil
			selectedTextRange = existingSelectedTextRange
		}
	}
}

extension TextFieldView {
	@objc
	private func textChanged(sender: UITextField) {
		if case let .focused(focused) = props.state {
			focused.onUpdate.perform(with: text)
		}
	}
}

extension TextFieldView: UITextFieldDelegate {
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if case let .focused(focused) = props.state {
			focused.onSubmit?.perform()
		}
		return true
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		if case let .blured(blured) = props.state {
			blured.onTap.perform()
		}
	}
	
	public func textFieldDidEndEditing(_ textField: UITextField) {
		if case let .focused(focused) = props.state {
			focused.onFinishEditing.perform()
		}
	}
}
