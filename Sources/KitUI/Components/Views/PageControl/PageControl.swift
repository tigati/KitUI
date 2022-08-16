import Foundation

public struct PageControl: IViewProps, Equatable {
	public static let type: String = String(reflecting: Self.self)
	
	public let numberOfPages: Int
	public let currentPage: Double
	public let isMomentary: Bool
	
	public init(numberOfPages: Int, currentPage: Double, isMomentary: Bool) {
		self.numberOfPages = numberOfPages
		self.currentPage = currentPage
		self.isMomentary = isMomentary
	}
}

extension PageControl {
	public static let initial = PageControl(numberOfPages: 1, currentPage: 0, isMomentary: true)
}

extension PageControl {
	public typealias View = PageControlView
}
