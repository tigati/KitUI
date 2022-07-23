import Foundation

extension MetaView {
	public static func textView(
		text: String?,
		state: MultilineTextField.State,
		style: MultilineTextField.Style
	) -> MetaView {
		.init(props: MultilineTextField(
			text: text,
			 placeholder: nil,
			 keyboardType: .default,
			 state: state,
			 style: style
		 )
		)
	}
}
