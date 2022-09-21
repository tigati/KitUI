import Foundation
import UIKit

@available(iOS 13, *)
public struct Menu: Equatable {
	public let title: String?
	public let image: UIImage?
	
	public let children: [Action]
	
	public init(
		title: String? = nil,
		image: UIImage? = nil,
		children: [Menu.Action]
	) {
		self.title = title
		self.image = image
		self.children = children
	}
}

@available(iOS 13, *)
extension Menu {
	public struct Action: Equatable {
		public let title: String
		public let image: UIImage?
		public let attributes: UIMenuElement.Attributes
		public let onTap: ViewCommand
		
		public init(
			title: String,
			image: UIImage?,
			attributes: UIMenuElement.Attributes = [],
			onTap: ViewCommand
		) {
			self.title = title
			self.image = image
			self.attributes = attributes
			self.onTap = onTap
		}
	}
}

@available(iOS 13, *)
extension Menu {
	func map() -> UIMenu {
		.init(
			title: title ?? "",
			image: image,
			children: children.map { $0.map() }
		)
	}
}

@available(iOS 13, *)
extension Menu.Action {
	func map() -> UIAction {
		UIAction(
			title: title,
			image: image,
			attributes: attributes
			) { _ in
				onTap.perform()
			}
	}
}
