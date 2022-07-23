import Foundation
import UIKit

public final class ScrollView: UIScrollView, IComponent {

	// MARK: - Typealias

	public typealias Style = Tappable.Style

	// MARK: - Private properties

	private var props: Scroll?

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

	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	// MARK: - Private methods

	func setup() {
		contentInsetAdjustmentBehavior = .always
		keyboardDismissMode = .interactive
		let notificationCenter = NotificationCenter.default
		
		notificationCenter.addObserver(
			self,
			selector: #selector(adjustForKeyboard),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
		notificationCenter.addObserver(
			self,
			selector: #selector(adjustForKeyboard),
			name: UIResponder.keyboardWillChangeFrameNotification,
			object: nil
		)
	}
	
	@objc
	func adjustForKeyboard(notification: Notification) {
		guard
				props?.shouldAdjustInsetsForKeyboard == true,
				let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
		else { return }
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
		
		if notification.name == UIResponder.keyboardWillHideNotification {
			contentInset = .zero
		} else {
			contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom, right: 0)
		}
		
		scrollIndicatorInsets = contentInset
	}
	

	// MARK: - Public methods

	public func render(props: Scroll) {
		defer { self.props = props }
		let oldValue = self.props

		if oldValue?.content.type != props.content.type {
			let view = props.content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}

		if let contentView = contentView
		{
			props.content.update(contentView)
			self.props = props
			setNeedsLayout()
		}
	}

	// MARK: - Private methods

	private func layout() {
		guard
			let props = props,
			let contentView = contentView
		else { return }

		let isHorizontal = props.axes.contains(.horizontal)
		let isVertical = props.axes.contains(.vertical)

		switch (isHorizontal, isVertical) {
		case (true, true):
			contentView.pin.sizeToFit()
		case (true, false):
			contentView.pin.top().left().vertically().sizeToFit(.height)
		case (false, true):
			contentView.pin.top().left().horizontally().sizeToFit(.width)
		case (false, false):
			return
		}

		contentSize = contentView.frame.size
	}
}
