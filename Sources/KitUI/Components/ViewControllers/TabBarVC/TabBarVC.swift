import Foundation
import UIKit

public struct TabBarVC: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	public static let initial = Self(
		tabs: [],
		selectedTabIndex: 0,
		modalVC: nil,
		style: .initial
	)

	// MARK: - Public

	/// Массив табов.
	public let tabs: [Tab]

	/// Выбранный таб
	public let selectedTabIndex: Int
	
	public let modalVC: ModalVC?

	public var style: Style = .initial

	// MARK: - Lifecycle

	public init(
		tabs: [Tab],
		selectedTabIndex: Int,
		modalVC: ModalVC?,
		style: Style
	) {
		self.tabs = tabs
		self.selectedTabIndex = selectedTabIndex
		self.modalVC = modalVC
		self.style = style
	}
}

public extension TabBarVC {

	struct Tab: Equatable {

		/// Заголовок для таба
		let title: String

		/// Иконка для таба
		let icon: ImageResource.Bundled

		/// Вьюконтроллер в табе
		let viewController: MetaVC

		/// Действие при нажатии на таб
		let onTap: ViewCommand

		// MARK: - Lifecycle

		public init(
			title: String,
			icon: ImageResource.Bundled,
			viewController: MetaVC,
			onTap: ViewCommand
		) {
			self.title = title
			self.icon = icon
			self.viewController = viewController
			self.onTap = onTap
		}
	}
}
