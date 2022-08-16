import Foundation

public extension MetaVC {
	static func rootVC(
		snackBar: MetaView? = nil,
		loadingView: MetaView? = nil,
		_ childVC: MetaVC
	) -> MetaVC {
		.init(
			props: RootVC(
				childVC: childVC,
				snackBar: snackBar,
				loadingView: loadingView
			)
		)
	}
}
