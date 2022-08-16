import Foundation
import UIKit

public struct RootVC: IViewProps, Equatable {
	// MARK: - Static

	public static let type: String = String(reflecting: Self.self)

	public typealias View = RootViewController

	// MARK: - Public

	public let childVC: MetaVC

	public let snackBar: MetaView?

	public let loadingView: MetaView?

	public init(
		childVC: MetaVC,
		snackBar: MetaView?,
		loadingView: MetaView?
	) {
		self.childVC = childVC
		self.snackBar = snackBar
		self.loadingView = loadingView
	}
}
