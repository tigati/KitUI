import UIKit

public final class TappableView: UIControl, IComponent {

	// MARK: - Typealias

	public typealias Style = Tappable.Style

	// MARK: - Private properties

	private var props: Tappable?

	/// Вью с содержимым
	private(set) var contentView: UIView?

	// MARK: - Lifecycle

	public init() {
		super.init(frame: .zero)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: - Override

	public override var isEnabled: Bool {
		didSet {
			updateVisualIfPropsAvaiable()
		}
	}

	public override var isHighlighted: Bool {
		didSet {
			guard props?.onHighlight != nil else { return }
			updateVisualIfPropsAvaiable()
		}
	}

	public override var isSelected: Bool {
		didSet {
			updateVisualIfPropsAvaiable()
		}
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		guard
			let contentView = contentView
		else {
			return .zero
		}
		return contentView.sizeThatFits(size)
	}

	// MARK: - Public methods

	public func render(props: Tappable) {
		self.props = props
		isEnabled = props.isEnabled
	}
	
	public func renderContent(_ content: MetaView) {
		if
			contentView == nil ||
			contentView?.isKind(of: content.viewType) == false {
			let view = content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}
		
		if let contentView = contentView {
			content.update(contentView)
		}
			
		setNeedsLayout()
	}

	// MARK: - Private methods

	private func setup() {
		addTarget(self, action: #selector(didTouchUpInside), for: .touchUpInside)
	}

	private func layout() {
		contentView?.pin.all()
	}
	
	private func updateVisualIfPropsAvaiable() {
		guard let props = self.props else { return }
		updateVisual(props: props)
	}

	private func updateVisual(props: Tappable) {
		self.contentView?.alpha = 1.0
		switch state {
		case .highlighted:
			if let onHighlight = props.onHighlight {
				renderContent(onHighlight)
			} else {
				scaleDown()
			}
		case .disabled:
			if let onDisable = props.onDisable {
				renderContent(onDisable)
			} else {
				renderContent(props.content)
				self.contentView?.alpha = props.style.disabledOpacity
			}
			scaleDown()
		default:
			renderContent(props.content)
			scaleBack()
		}
	}

	private func scaleDown() {
		let scale = props?.style.pressedScale ?? 1.0
		UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
			self.contentView?.transform = CGAffineTransform(scaleX: scale, y: scale)
		})
	}

	private func scaleBack() {
		UIView.animate(withDuration: 0.2, delay: 0, options: .allowUserInteraction, animations: {
			self.contentView?.transform = .identity
		})
	}

	@objc
	private func didTouchUpInside() {
		props?.onTap?.perform()
	}
}
