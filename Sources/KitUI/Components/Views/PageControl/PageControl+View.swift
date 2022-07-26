import Foundation
import QuartzCore
import UIKit

public final class PageControlView: ComponentView, IComponent {
	
	enum Constants {
		static let pageLength: Double = 6
		static let currentPageLength: Double = 12
		static let space: Double = 4
	}
	
	private var props: PageControl = .initial
	
	private var pageLayers: [CALayer] = []
	
	public func render(props: PageControl) {
		defer { self.props = props }
		if self.props.numberOfPages != props.numberOfPages {
			updatePages(count: props.numberOfPages)
			setNeedsLayout()
		}
		if self.props.currentPage != props.currentPage {
			setNeedsLayout()
		}
	}
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		let width = Double(props.numberOfPages - 1) * (Constants.pageLength + Constants.space) + Constants.currentPageLength
		let height = Constants.pageLength
		return CGSize(width: width, height: height)
	}
	
	public override func layout() {
		var x: Double = 0
		for pageIndex in props.numberOfPages {
			let floatPageIndex = Double(pageIndex)
			let width: Double
			let progress: Double
			if floatPageIndex == floor(props.currentPage) {
				progress = 1 - (props.currentPage - floatPageIndex)
				width = (1 - (props.currentPage - floatPageIndex)) * (Constants.currentPageLength - Constants.pageLength) + Constants.pageLength
			} else if floatPageIndex == ceil(props.currentPage) {
				progress = 1 - (floatPageIndex - props.currentPage)
				width = (1 - (floatPageIndex - props.currentPage)) * (Constants.currentPageLength - Constants.pageLength) + Constants.pageLength
			} else {
				progress = 0
				width = Constants.pageLength
			}
			
			let layer = pageLayers[pageIndex]
			CATransaction.begin()
			if props.isMomentary {
				CATransaction.setDisableActions(true)
			} else {
				CATransaction.setAnimationDuration(0.5)
			}
			
			if props.currentPage < 0 && pageIndex == 0 {
				x = x + (Constants.currentPageLength - width)
			}

			layer.frame = CGRect(x: x, y: 0, width: width, height: Constants.pageLength)
			
			layer.backgroundColor = color(
				startColor: props.inactiveColor.cgColor,
				endColor: props.activeColor.cgColor,
				progress: progress
			)

			CATransaction.commit()
			
			x += Constants.space + width
			
		}
	}
	
	private func color(
		startColor: CGColor,
		endColor: CGColor,
		progress: Double
	) -> CGColor {
		let f = min(max(0, progress), 1)

		guard
			let c1 = startColor.components,
			let c2 = endColor.components
		else { return UIColor.clear.cgColor }

		let r: CGFloat = CGFloat(c1[0] + (c2[0] - c1[0]) * f)
		let g: CGFloat = CGFloat(c1[1] + (c2[1] - c1[1]) * f)
		let b: CGFloat = CGFloat(c1[2] + (c2[2] - c1[2]) * f)
		let a: CGFloat = CGFloat(c1[3] + (c2[3] - c1[3]) * f)


		return UIColor(red: r, green: g, blue: b, alpha: a).cgColor
	}
	
	private func updatePages(count: Int) {
		pageLayers.forEach { layer in
			layer.removeFromSuperlayer()
		}
		pageLayers = []
		
		for _ in count {
			let pageLayer = CAGradientLayer()
			pageLayer.cornerRadius = Constants.pageLength / 2
			layer.addSublayer(pageLayer)
			self.pageLayers.append(pageLayer)
		}
	}
}
