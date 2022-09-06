import Foundation
import UIKit

public struct Alert: IViewProps, Equatable {
	public static let type: String = String(reflecting: Self.self)
	
	public typealias View = UIAlertController
	
	
	public let title: String?
	public let message: String?
	public let actions: [Action]
	public let style: UIAlertController.Style
	
	public struct Action: Equatable {
		public let title: String
		public let style: UIAlertAction.Style
		public let onTap: ViewCommand
		
		public init(title: String, style: UIAlertAction.Style, onTap: ViewCommand) {
			self.title = title
			self.style = style
			self.onTap = onTap
		}
	}
	
	public init(
		title: String?,
		message: String?,
		actions: [Alert.Action],
		style: UIAlertController.Style)
	{
		self.title = title
		self.message = message
		self.actions = actions
		self.style = style
	}
	
	public func makeView(viewType: UIAlertController.Type) -> UIAlertController {
		let controller = UIAlertController(title: title, message: message, preferredStyle: style)
		actions.forEach { action in
			let action = UIAlertAction(
				title: action.title,
				style: action.style
			) { _ in
				action.onTap.perform()
			}
			controller.addAction(action)
		}
		return controller
	}
}

extension UIAlertController: IComponent {
	public func render(props: Alert) {
		
	}
	
	open override func setViewID(_ viewID: String) {
		
	}
	
	open override func getViewID() -> String {
		"UIAlertController"
	}
}
