import Foundation
import UIKit

public struct PageControl: IViewProps, Equatable {
	public static let type: String = String(reflecting: Self.self)
	
	public let numberOfPages: Int
	public let currentPage: Double
	public let isMomentary: Bool
	public let activeColor: UIColor
	public let inactiveColor: UIColor
	
	public init(
		numberOfPages: Int,
		currentPage: Double,
		isMomentary: Bool,
		activeColor: UIColor,
		inactiveColor: UIColor
	) {
		self.numberOfPages = numberOfPages
		self.currentPage = currentPage
		self.isMomentary = isMomentary
		self.activeColor = activeColor
		self.inactiveColor = inactiveColor
	}
}

extension PageControl {
	public static let initial = PageControl(
		numberOfPages: 1,
		currentPage: 0,
		isMomentary: true,
		activeColor: .black,
		inactiveColor: .gray
	)
}

extension PageControl {
	public typealias View = PageControlView
}
