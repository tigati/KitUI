import Foundation
import UIKit

public enum BarItem: Equatable {
	case system(SystemBarItem)
	case regular(RegularBarItem)
	
	public static func system(
		type: UIBarButtonItem.SystemItem,
		tintColor: UIColor,
		primaryAction: ViewCommand?,
		menu: Menu?
	) -> Self {
		.system(
			.init(
				type: type,
				tintColor: tintColor,
				primaryAction: primaryAction,
				menu: menu
			)
		)
	}
	
	public static func regular(
	title: String?,
	image: UIImage?,
	tintColor: UIColor,
	primaryAction: ViewCommand?,
	menu: Menu?
	) -> Self {
		.regular(
			.init(
				title: title,
				image: image,
				tintColor: tintColor,
				primaryAction: primaryAction,
				menu: menu
			)
		)
	}
}

public struct SystemBarItem: Equatable {
	public let type: UIBarButtonItem.SystemItem
	public let tintColor: UIColor
	public let primaryAction: ViewCommand?
	public let menu: Menu?
}

public struct RegularBarItem: Equatable {
	public let title: String?
	public let image: UIImage?
	public let tintColor: UIColor
	public let primaryAction: ViewCommand?
	public let menu: Menu?
}

extension BarItem {
	func map() -> UIBarButtonItem {
		switch self {
		case let .regular(item):
			return mapRegular(item)
		case let .system(item):
			return mapSystem(item)
		}
	}
	
	private func mapSystem(_ item: SystemBarItem) -> UIBarButtonItem {
		let primaryAction = item.primaryAction.map { command in
			UIAction { _ in command.perform() }
		}
		
		let button = UIBarButtonItem(
			systemItem: item.type,
			primaryAction: primaryAction,
			menu: item.menu.map { $0.map() }
		)
		
		button.tintColor = item.tintColor
		
		return button
	}
	
	private func mapRegular(_ item: RegularBarItem) -> UIBarButtonItem {
		let primaryAction = item.primaryAction.map { command in
			UIAction { _ in command.perform() }
		}

		let button = UIBarButtonItem(
			title: item.title,
			image: item.image,
			primaryAction: primaryAction,
			menu: item.menu.map { $0.map() }
		)

		button.tintColor = item.tintColor

		return button
	}
}
