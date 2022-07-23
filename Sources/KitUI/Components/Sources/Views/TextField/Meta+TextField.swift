import Foundation
import UIKit

extension MetaView {
	public static func textField(
		text: String?,
		placeholder: String?,
		isSecureTextEntry: Bool,
		keyboardType: UIKeyboardType,
		state: TextField.State,
		style: TextField.Style
	) -> MetaView {
		.init(
			props: TextField(
				text: text,
				placeholder: placeholder,
				isSecureTextEntry: isSecureTextEntry,
				keyboardType: keyboardType,
				state: state,
				style: style
			)
		)
	}
}
