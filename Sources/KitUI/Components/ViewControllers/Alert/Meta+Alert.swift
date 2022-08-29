import Foundation
import UIKit

extension MetaVC {
	public static func alertVC(
		title: String?,
		message: String?,
		actions: [Alert.Action],
		style: UIAlertController.Style
	) -> MetaVC {
		.init(
			props: Alert(
				title: title,
				message: message,
				actions: actions,
				style: style
			)
		)
	}
	
	public static func alertVC(
		title: String?,
		message: String?,
		actions: Alert.Action...,
		style: UIAlertController.Style
	) -> MetaVC {
		alertVC(title: title, message: message, actions: actions, style: style)
	}
}
