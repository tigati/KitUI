import Foundation
import UIKit

public class ViewController: UIViewController {
	
	private var _viewID: String = ""
	
	public override func setViewID(_ viewID: String) {
		_viewID = viewID
	}
	
	public override func getViewID() -> String {
		_viewID
	}
	
	public init() {
		super.init(nibName: nil, bundle: nil)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	open func setup() {
		
	}
}
