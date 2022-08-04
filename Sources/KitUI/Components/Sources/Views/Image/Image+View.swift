import UIKit

public final class ImageView: UIImageView, IComponent {

	// MARK: - Private properties

	private var props: Image = .initial

	// MARK: - Public methods

	public func render(props: Image) {
		self.props = props
		if let imageResource = props.resource {
			switch imageResource {
			case let .bundled(bundled):
				image = UIImage(named: bundled.name, in: bundled.bundle, compatibleWith: nil)
			case let .url(url):
				break
			}
		} else {
			image = nil
		}
		
		switch props.style.fill {
		case .solid(let color):
			tintColor = color
		default:
			break
		}
		
		backgroundColor = props.style.backgroundColor
		contentMode = props.style.contentMode
		setNeedsLayout()
	}

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard let image = image else {
			return super.sizeThatFits(size)
		}

		if image.size.width == 0 || image.size.height == 0 {
			return super.sizeThatFits(size)
		}
		
		let style = props.style

		// И ширина и высота не заданы
		if
			style.size.height == UIView.noIntrinsicMetric,
			style.size.width == UIView.noIntrinsicMetric
		{
			return super.sizeThatFits(size)
		}

		// Высота определена, ширина не задана
		if
			style.size.width == UIView.noIntrinsicMetric,
			style.size.height != UIView.noIntrinsicMetric {
			return CGSize(
				width: image.size.width * style.size.height / image.size.height,
				height: style.size.height
			)
		}

		// Ширина определена, высота не задана
		if
			style.size.height == UIView.noIntrinsicMetric,
			style.size.width != UIView.noIntrinsicMetric
		{
			return CGSize(
				width: style.size.width,
				height: image.size.height * style.size.width / image.size.width
			)
		}

		return style.size
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	func layout() {
		if case .gradient(let gradient) = props.style.fill {
			applyGradient(gradient)
		}
	}
}
