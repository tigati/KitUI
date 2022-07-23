import Foundation
import UIKit

open class ComponentView: UIView {
	public required init() {
		super.init(frame: .zero)
		setup()
	}

	required public init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}
	
	open func setup() { }
	
	open func layout() { }
	
	public override func didAddSubview(_ subview: UIView) {
		// делал
	}
	
	public override func willRemoveSubview(_ subview: UIView) {
		
	}
}
