import Foundation

extension MetaVC {
	public static func viewController(
		navigationBar: NavigationBar? = nil,
		_ view: MetaView,
		modalVC: ModalVC? = nil,
		onViewDidAppear: ViewCommand? = nil,
		onViewDidDisappear: ViewCommand? = nil
	) -> MetaVC {
		.init(
			props: RegularVC(
				navigationBar: navigationBar,
				view: view,
				modalVC: modalVC,
				onViewDidAppear: onViewDidAppear,
				onViewDidDisappear: onViewDidDisappear
			)
		)
	}
	
	public static let nilViewController = MetaVC.init(props: Optional<RegularVC>.none)
}
