import UIKit
import DifferenceKit

/// Вью стека
public final class StackView: UIView, IComponent {
	
	// MARK: - Private properties
	
	private var props: Stack = .initial {
		didSet {
			render(old: oldValue, new: props)
		}
	}
	
	private var components: Components?
	
	// MARK: - Lifecycle
	
	public init() {
		super.init(frame: .zero)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Overrides
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	public override func sizeThatFits(
		_ size: CGSize
	) -> CGSize {
		var size = size
		if size.width == .infinity || size.width == .greatestFiniteMagnitude {
			size.width = 0
		}
		if size.height == .infinity || size.height == .greatestFiniteMagnitude {
			size.height = 0
		}
		self.components?.calculateSizes(sizeToFit: size)
		return components?.combinedSize() ?? .zero
	}
	
	public override func hitTest(
		_ point: CGPoint,
		with event: UIEvent?
	) -> UIView? {
		let view = super.hitTest(point, with: event)
		return view == self ? nil : view
	}
	
	// MARK: - Public methods
	
	public func render(props: Stack) {
		self.props = props
	}
	
	// MARK: - Private methods
	
	private func layout() {
		guard let data = self.components else {
			return
		}
		
		data.calculateSizes(sizeToFit: bounds.size)
		
		var offset: CGFloat = 0
		
		for (index, view) in data.views.enumerated() {
			let size = data.cgSizes[index]
			
			switch props.axis {
			case .vertical:
				let x: CGFloat
				switch props.alignment.horizontal {
				case .leading:
					x = 0
				case .trailing:
					x = bounds.size.width - size.width
				case .center:
					x = (bounds.size.width - size.width) / 2
				}
				view.frame = CGRect(
					x: x,
					y: offset,
					width: size.width,
					height: size.height
				)
			case .horizontal:
				let y: CGFloat
				switch props.alignment.vertical {
				case .top:
					y = 0
				case .bottom:
					y = bounds.size.height - size.height
				case .center:
					y = (bounds.size.height - size.height) / 2
				}
				view.frame = CGRect(
					x: offset,
					y: y,
					width: size.width,
					height: size.height
				)
			}
			
			offset += props.spacing + data.sizes[index].alongLength
		}
	}
	
	private func render(old: Stack, new: Stack) {
		let changeSet = StagedChangeset(source: old.items, target: new.items)
		
		guard changeSet.isEmpty == false else {
			return
		}
		
		var views: [UIView] = getComponentViews()
		
		for changes in changeSet {
			for delete in changes.elementDeleted {
				let view = views[delete.element]
				view.removeFromSuperview()
				views.remove(at: delete.element)
			}
			for insert in changes.elementInserted {
				let component = changes.data[insert.element].makeView()
				views.insert(component, at: insert.element)
				changes.data[insert.element].update(component)
				addSubview(component)
			}
			for update in changes.elementUpdated {
				let component = views[update.element]
				changes.data[update.element].update(component)
			}
			for (source, target) in changes.elementMoved {
				views.swapAt(source.element, target.element)
			}
		}
		
		self.components = Components(props: props, views: views)
		
		setNeedsLayout()
	}
	
	private func getComponentViews() -> [UIView] {
		if let components = self.components {
			return components.views
		}
		return []
	}
}

