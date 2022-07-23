import Foundation
import UIKit

/// Реализация `UIWindow`, как компонента,
/// с возможностью задавать пропсы.
public final class Window: UIWindow, IComponent {

	// MARK: - Internal properties

	var props: Props?

	// MARK: - Public methods

	public func render(props: Props) {
		defer { self.props = props }
		if props.viewController.type != self.props?.viewController.type {
			let viewController = props.viewController.makeView()
			props.viewController.update(viewController)
			self.rootViewController = viewController
			return
		}

		if let viewController = rootViewController {
			props.viewController.update(viewController)
		}
	}
}

// MARK: - Props

extension Window {

	public struct Props: IProps {

		// MARK: - Static

		public static let type: String = String(reflecting: Self.self)

		// MARK: - Internal

		let viewController: MetaVC

		// MARK: - Lifecycle

		public init(viewController: MetaVC) {
			self.viewController = viewController
		}
	}
}
