import Foundation
import UIKit

extension TabBarVC {
	public typealias View = TabBarViewController
}

/// Вьюконтроллер для `TabBarVC`
public final class TabBarViewController: UITabBarController, IComponent {

	// MARK: - Private properties

	private var props: TabBarVC = .initial

	// MARK: - Lifecycle

	public init() {
		super.init(nibName: nil, bundle: nil)
		delegate = self
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Public methods

	public func render(props: TabBarVC) {

		let oldTabs = self.props.tabs
		let newTabs = props.tabs
//
//		let changes = diff(old: oldTabs, new: newTabs)
//
//		var optionalNewViewControllers: [UIViewController?] = viewControllers ?? []
//
//		changes.forEach { change in
//			switch change {
//			case let .delete(delete):
//				optionalNewViewControllers[delete.index] = nil
//			case let .insert(insert):
//				let viewController = insert.item.viewController.makeView()
//				optionalNewViewControllers.insert(viewController, at: insert.index)
//			case .move, .replace:
//				break
//			}
//		}
//
//		let newViewControllers = optionalNewViewControllers.compactMap { $0 }
//
//		setViewControllers(newViewControllers, animated: false)
//
//		zip(newViewControllers, newTabs).forEach { viewController, tab in
//			tab.viewController.update(viewController)
//			viewController.tabBarItem.title = tab.title
//			viewController.tabBarItem.image = tab.icon.image
//		}
//
//		selectedIndex = props.selectedTabIndex
//
//		tabBar.tintColor = props.style.selectedColor
//		tabBar.unselectedItemTintColor = props.style.unselectedColor
//		tabBar.barTintColor = props.style.tabBarColor

		self.props = props
	}
}

// MARK: - UITabBarControllerDelegate

extension TabBarViewController: UITabBarControllerDelegate {

	public func tabBarController(
		_ tabBarController: UITabBarController,
		didSelect viewController: UIViewController
	) {
		guard let index = viewControllers?.firstIndex(of: viewController)
		else { return }
		props.tabs[index].onTap.perform()
	}
}
