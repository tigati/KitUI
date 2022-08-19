import Foundation

extension MetaView {
	public static func textView(
		changeID: TextFieldChangeID,
		text: String?,
		placeholder: String?,
		state: MultilineTextField.State,
		traits: TextInputTraits,
		style: MultilineTextField.Style
	) -> MetaView {
		.init(
			props: MultilineTextField(
				changeID: changeID,
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
