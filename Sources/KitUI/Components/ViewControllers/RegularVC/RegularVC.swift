import Foundation

public struct RegularVC: IViewProps, Equatable {

	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	// MARK: - Public

	public let navigationBar: NavigationBar?
	public let view: MetaView
	public let modalVC: ModalVC?
	public let onViewDidLoad: ViewCommand?
	public let onViewDidAppear: ViewCommand?
	public let onViewDidDisappear: ViewCommand?

	// MARK: - Lifecycle

	public init(
		navigationBar: NavigationBar?,
		view: MetaView,
		modalVC: ModalVC? = nil,
		onViewDidLoad: ViewCommand? = nil,
		onViewDidAppear: ViewCommand? = nil,
		onViewDidDisappear: ViewCommand? = nil
	) {
		self.navigationBar = navigationBar
		self.view = view
		self.modalVC = modalVC
		self.onViewDidLoad = onViewDidLoad
		self.onViewDidAppear = onViewDidAppear
		self.onViewDidDisappear = onViewDidDisappear
	}
}

extension RegularVC {
	public typealias View = RegularViewController
}
