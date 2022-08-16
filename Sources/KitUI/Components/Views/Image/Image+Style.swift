import UIKit

extension Image {

	public struct Style: Equatable {

		public static let initial = Style(
			contentMode: .scaleAspectFit,
			size: noIntrinsicMetricSize
		)
		public static let noIntrinsicMetricSize = CGSize(
			width: UIView.noIntrinsicMetric,
			height: UIView.noIntrinsicMetric
		)

		public let fill: FillStyle?
		public let backgroundColor: UIColor?
		public let contentMode: UIView.ContentMode
		public let size: CGSize

		// MARK: - Lifecycle

		public init(
			fill: FillStyle? = nil,
			backgroundColor: UIColor? = nil,
			contentMode: UIView.ContentMode = .scaleAspectFit,
			size: CGSize = noIntrinsicMetricSize
		) {
			self.fill = fill
			self.backgroundColor = backgroundColor
			self.contentMode = contentMode
			self.size = size
		}
	}
}
