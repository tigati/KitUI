import UIKit

/// Обёртка над компонентом
/// для размещения внутри стека
public final class MetaView: Equatable, Identifiable {
	
	// MARK: - Public properties
	
	public let type: String
	
	public let viewType: UIView.Type
	
	public let tableCellViewType: UITableViewCell.Type
	public let headerFooterViewType: UITableViewHeaderFooterView.Type

	public private(set) var id: String?

	private(set) var props: IProps

	private(set) var layoutPriority: Int
	
	private(set) var isHidden: Bool
	
	private(set) var transitionAnimationDuration: Double?

	// MARK: - Private properties

	private let equals: (MetaView, MetaView) -> Bool

	private let _update: (UIView, IProps) -> Void
	
	private let _makeView: () -> UIView
	
	private let _copy: (
		_ id: String?,
		_ layoutPriority: Int,
		_ isHidden: Bool,
		_ transitionAnimationDuration: Double?
	) -> MetaView

	// MARK: - Lifecycle

	public init<TProps: IViewProps>(
		id: String? = nil,
		props: TProps,
		layoutPriority: Int = 0,
		isHidden: Bool = false,
		transitionAnimationDuration: Double? = nil
	) where TProps: Equatable, TProps.View: IComponent & UIView, TProps.View.Props == TProps {
		self.type = TProps.type
		self.viewType = TProps.View.self
		self.tableCellViewType = TableCellView<TProps.View>.self
		self.headerFooterViewType = TableHeaderFooterView<TProps.View>.self
		self.id = id ?? TProps.type
		self.props = props

		self.layoutPriority = layoutPriority
		self.isHidden = isHidden
		self.transitionAnimationDuration = transitionAnimationDuration
		
		self._update = { view, props in
			guard
				let view = view as? TProps.View,
				let props = props as? TProps
			else { fatalError() }
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
			lhs.layoutPriority == rhs.layoutPriority &&
			lhs.isHidden == rhs.isHidden &&
			lhs.type == rhs.type &&
			lhs.id == rhs.id
		}
		self._makeView = {
			props.makeView(viewType: TProps.View.self)
		}
		
		self._copy = { id, layoutPriority, isHidden, transitionAnimationDuration in
			MetaView(
				id: id, props: props,
				layoutPriority: layoutPriority,
				isHidden: isHidden,
				transitionAnimationDuration: transitionAnimationDuration
			)
		}
	}

	// MARK: - Public methods
	
	public func update(_ view: UIView) {
		view.isHidden = isHidden
		if let transitionAnimationDuration = transitionAnimationDuration {
			view.fadeTransition(transitionAnimationDuration)
		}
		_update(view, props)
	}
	
	public func makeView() -> UIView {
		let view = _makeView()
		view.isHidden = isHidden
		return view
	}
	
	public func copy(
		id: String?,
		layoutPriority: Int,
		isHidden: Bool,
		transitionAnimationDuration: Double?
	) -> MetaView {
		_copy(id, layoutPriority, isHidden, transitionAnimationDuration)
	}
	
	public func copy(
		id: String?
	) -> MetaView {
		_copy(
			id,
			self.layoutPriority,
			self.isHidden,
			self.transitionAnimationDuration
		)
	}
	
	public func copy(
		layoutPriority: Int
	) -> MetaView {
		_copy(
			self.id,
			layoutPriority,
			self.isHidden,
			self.transitionAnimationDuration
		)
	}
	
	public func copy(
		isHidden: Bool
	) -> MetaView {
		_copy(
			self.id,
			self.layoutPriority,
			isHidden,
			self.transitionAnimationDuration
		)
	}
	
	public func copy(
		transitionAnimationDuration: Double?
	) -> MetaView {
		_copy(
			self.id,
			self.layoutPriority,
			self.isHidden,
			transitionAnimationDuration
		)
	}

	public func isEqual(_ other: MetaView) -> Bool {
		equals(self, other)
	}

	public static func == (
		lhs: MetaView,
		rhs: MetaView
	) -> Bool {
		lhs.isEqual(rhs)
	}
}
