import Foundation
import UIKit

extension MetaView {
	public static func textField(
		text: String?,
		placeholder: String?,
		state: TextField.State,
		traits: TextInputTraits,
		style: TextField.Style
	) -> MetaView {
		.init(
			props: TextField(
				text: text,
				placeholder: placeholder,
				state: state,
				traits: traits,
				style: style
			)
		)
	}
}
