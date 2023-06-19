import UIKit

final class BottomView: ComponentView {
    
    private var contentViewType: String?
    
    var contentView: UIView?
    
    let backgroundView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    
    override func setup() {
        addSubview(backgroundView)
    }
    
    func render(metaView: MetaView) {
        if contentView == nil || contentViewType != metaView.type {
            let newView = metaView.makeView()
            contentViewType = metaView.type
            contentView?.removeFromSuperview()
            contentView = newView
            addSubview(newView)
        }
        
        if let contentView {
            metaView.update(contentView)
            setNeedsLayout()
        }
    }
    
    override func layout() {
        backgroundView.pin.all()
        contentView?
            .pin
            .horizontally()
            .sizeToFit(.width)
            .top()
    }
}
