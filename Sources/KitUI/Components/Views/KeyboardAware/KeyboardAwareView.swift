import Foundation
import UIKit

public final class KeyboardAwareView: ComponentView, IComponent {
	
	private var contentView: UIView?
	
	private var props: KeyboardAware?
	
	private var keyboardHeight: CGFloat = 0
	
	private var adjustKeyboardTask: DispatchWorkItem?
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		size
	}
	
	public override func setup() {
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
	
	public func render(props: KeyboardAware) {
		defer { self.props = props }
		let oldValue = self.props
		
		if oldValue?.content.type != props.content.type {
			let view = props.content.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}
		
		if let contentView = contentView {
			props.content.update(contentView)
			setNeedsLayout()
		}
	}
	
	@objc
	func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
		if notification.name == UIResponder.keyboardWillHideNotification {
			keyboardHeight = 0
		} else {
			keyboardHeight = keyboardViewEndFrame.height
		}
		
		guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
		
		UIView.animate(withDuration: keyboardAnimationDuration.doubleValue) {
			self.setNeedsLayout()
			self.layoutIfNeeded()
		}
	}
	
	public override func layout() {
		self.contentView?.pin.top().horizontally().bottom(self.keyboardHeight)
	}
}
