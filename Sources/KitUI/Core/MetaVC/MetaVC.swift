import UIKit

/// Обёртка над пропсами `ViewController`
/// для размещения внутри других компонентов `ViewController`
public final class MetaVC: Equatable {

	// MARK: - Public properties

	public let type: String

	public let id: String
	
	// MARK: - Internal properties

	var props: IProps?

	// MARK: - Private properties

	private let _update: (UIViewController, IProps?) -> Void

	private let _makeView: () -> UIViewController
	
	private let _copy: (_ id: String?) -> MetaVC

	private let equals: (MetaVC, MetaVC) -> Bool

	// MARK: - Lifecycle

	public init<TProps: IViewProps>(
		id: String? = nil,
		props: TProps?
	) where TProps: Equatable,
	TProps.View: IComponent & UIViewController,
	TProps.View.Props == TProps {
		self.type = TProps.type
		self.id = id ?? TProps.type
		self.props = props

		self._update = { view, props in
			guard
				let view = view as? TProps.View,
				let props = props as? TProps
			else { return }
			view.render(props: props)
		}
		self.equals = { lhs, rhs in
			guard
				let lhsProps = lhs.props as? TProps,
				let rhsProps = rhs.props as? TProps
			else {
				return false
			}
			return lhsProps == rhsProps &&
			lhs.type == rhs.type &&
			lhs.id == rhs.id
		}

		self._makeView = {
			guard let view = props?.makeView(viewType: TProps.View.self) else {
				let viewType = TProps.View.self
				return viewType.init()
			}
			return view
		}
		
		self._copy = { id in
			MetaVC(
				id: id,
				props: props
			)
		}
	}

	// MARK: - Public methods

	public func update(_ view: UIViewController) {
		view.setViewID(self.id)
		_update(view, props)
	}

	public func makeView() -> UIViewController {
		let view = _makeView()
		view.setViewID(self.id)
		return view
	}
	
	public func copy(
		id: String?
	) -> MetaVC {
		_copy(id)
	}

	public func isEqual(_ other: MetaVC) -> Bool {
		equals(self, other)
	}

	public static func == (
		lhs: MetaVC,
		rhs: MetaVC
	) -> Bool {
		lhs.isEqual(rhs)
	}
}
