import Foundation
import UIKit

public final class RootView: UIView {
	private var contentViewType: String?
	
	private var contentView: UIView?
	
	public func render(metaView: MetaView) {
		defer { self.contentViewType = metaView.type }
		
		if contentViewType != metaView.type {
			let view = metaView.makeView()
			contentView?.removeFromSuperview()
			contentView = view
			addSubview(view)
		}
		
		if let contentView = contentView
		{
			metaView.update(contentView)
			setNeedsLayout()
		}
	}
	
	public override func layoutSubviews() {
		super.layoutSubviews()
		contentView?.pin.all()
	}
}
