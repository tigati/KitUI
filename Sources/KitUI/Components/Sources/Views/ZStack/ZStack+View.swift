import UIKit
import DifferenceKit
import PinLayout

public final class ZStackView: UIView, IComponent {

	// MARK: - Private properties

	private var props: ZStack = .initial {
		didSet {
			render(old: oldValue, new: props)
		}
	}

	private var components: [UIView] = []

	// MARK: - Lifecycle

	public init() {
		super.init(frame: .zero)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		let components = zip(components, props.items)
		let size = components.reduce(CGSize.zero, { partialResult, pair in
			let size = pair.0.sizeThatFits(size)
			return CGSize(
				width: max(partialResult.width, size.width),
				height: max(partialResult.height, size.height)
			)
		})
		
		return size
	}

	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		let view = super.hitTest(point, with: event)
		let returnView =  view == self ? nil : view
		return returnView
	}

	// MARK: - Public methods

	public func render(props: ZStack) {
		self.props = props
	}

	// MARK: - Private methods

	private func render(old: Props, new: Props) {
		let changeset = StagedChangeset(source: old.items, target: new.items)
		
		guard changeset.isEmpty == false else {
			return
		}
		
		for changes in changeset {
			for delete in changes.elementDeleted {
				let view = components[delete.element]
				view.removeFromSuperview()
				components.remove(at: delete.element)
			}
			for insert in changes.elementInserted {
				let component = props.items[insert.element].makeView()
				components.insert(component, at: insert.element)
				props.items[insert.element].update(component)
				addSubview(component)
			}
			for update in changes.elementUpdated {
				let component = components[update.element]
				props.items[update.element].update(component)
			}
			for (source, target) in changes.elementMoved {
				components.swapAt(source.element, target.element)
			}
		}

		setNeedsLayout()
	}

	private func layout() {
		zip(components, props.items).forEach { component, componentProps in
			bringSubviewToFront(component)
			
			let size = component.sizeThatFits(bounds.size)
			
			switch (props.alignment.horizontal, props.alignment.vertical) {
			case (.leading, .top):
				component.pin.left().top().size(size)
			case (.leading, .center):
				component.pin.left().vCenter().size(size)
			case (.leading, .bottom):
				component.pin.left().bottom().size(size)
			case (.center, .top):
				component.pin.hCenter().top().size(size)
			case (.center, .center):
				component.pin.hCenter().vCenter().size(size)
			case (.center, .bottom):
				component.pin.hCenter().bottom().size(size)
			case (.trailing, .top):
				component.pin.right().top().size(size)
			case (.trailing, .center):
				component.pin.right().vCenter().size(size)
			case (.trailing, .bottom):
				component.pin.right().bottom().size(size)
			}
			
//			let componentSize = component.sizeThatFits(bounds.size)
//
//			let x: CGFloat
//
//			switch props.alignment.horizontal {
//			case .leading:
//				x = 0
//			case .center:
//				x = (bounds.width - componentSize.width) / 2
//			case .trailing:
//				x = bounds.width - componentSize.width
//			}
//
//			let y: CGFloat
//
//			switch props.alignment.vertical {
//			case .top:
//				y = 0
//			case .center:
//				y = (bounds.height - componentSize.height) / 2
//			case .bottom:
//				y = bounds.height - componentSize.height
//			}
//
//
//
//			component.frame = CGRect(
//				x: x,
//				y: y,
//				width: componentSize.width,
//				height: componentSize.height
//			)
		}
	}
}
