import Foundation
import UIKit
import DifferenceKit

extension TabBarVC {
	public typealias View = TabBarViewController
}

/// Вьюконтроллер для `TabBarVC`
public final class TabBarViewController: UITabBarController, IComponent {

	// MARK: - Private properties
	
	private var _viewID: String = ""

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
	
	public override func setViewID(_ viewID: String) {
		_viewID = viewID
	}
	
	public override func getViewID() -> String {
		_viewID
	}

	public func render(props: TabBarVC) {

		let oldTabs = self.props.tabs
		let newTabs = props.tabs
		
		let diff = newTabs.count - oldTabs.count
		
		var newViewControllers: [UIViewController] = viewControllers ?? []
		
		// new tabs added
		if diff > 0 {
			let addedTabs = newTabs.suffix(diff)
			addedTabs.forEach { tab in
				let viewController = tab.viewController.makeView()
				newViewControllers.append(viewController)
			}
			setViewControllers(newViewControllers, animated: true)
		}
		
		// tabs removed
		if diff < 0 {
			newViewControllers.removeLast(abs(diff))
			setViewControllers(newViewControllers, animated: true)
		}
		
		selectedIndex = props.selectedTabIndex
		let activeViewController = newViewControllers[props.selectedTabIndex]
		props.tabs[props.selectedTabIndex].viewController.update(activeViewController)
		
		tabBar.tintColor = props.style.selectedColor
		tabBar.unselectedItemTintColor = props.style.unselectedColor
		tabBar.barTintColor = props.style.tabBarColor
		
		zip(newViewControllers, newTabs).forEach { viewController, tab in
			viewController.tabBarItem.title = tab.title
			viewController.tabBarItem.image = UIImage(named: tab.icon.name, in: tab.icon.bundle, compatibleWith: nil)
		}

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
