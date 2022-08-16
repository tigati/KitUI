import Foundation

extension MetaView {
	public static func textView(
		text: String?,
		placeholder: String?,
		state: MultilineTextField.State,
		traits: TextInputTraits,
		style: MultilineTextField.Style
	) -> MetaView {
		.init(
			props: MultilineTextField(
				text: text,
				placeholder: placeholder,
				keyboardType: .default,
				state: state,
				traits: traits,
				style: style
			)
		)
	}
}
