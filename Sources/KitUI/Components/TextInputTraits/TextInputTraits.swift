import Foundation
import UIKit

public struct TextInputTraits: Equatable {
	public let keyboardType: UIKeyboardType
	public let keyboardAppearance: UIKeyboardAppearance
	public var returnKeyType: UIReturnKeyType
	public let textContentType: UITextContentType?
	public var secureTextEntry: Bool
	public let autocapitalizationType: UITextAutocapitalizationType
	public let autocorrectionType: UITextAutocorrectionType
	public let spellCheckingType: UITextSpellCheckingType
	
	public init(
		keyboardType: UIKeyboardType = .default,
		keyboardAppearance: UIKeyboardAppearance = .default,
		returnKeyType: UIReturnKeyType = .default,
		textContentType: UITextContentType? = nil,
		secureTextEntry: Bool = false,
		autocapitalizationType: UITextAutocapitalizationType = .sentences,
		autocorrectionType: UITextAutocorrectionType = .default,
		spellCheckingType: UITextSpellCheckingType = .default
	) {
		self.keyboardType = keyboardType
		self.keyboardAppearance = keyboardAppearance
		self.returnKeyType = returnKeyType
		self.textContentType = textContentType
		self.secureTextEntry = secureTextEntry
		self.autocapitalizationType = autocapitalizationType
		self.autocorrectionType = autocorrectionType
		self.spellCheckingType = spellCheckingType
	}
}

extension TextInputTraits {
	public func withReturnKeyType(_ returnKeyType: UIReturnKeyType) -> TextInputTraits {
		var new = self
		new.returnKeyType = returnKeyType
		return new
	}
}
