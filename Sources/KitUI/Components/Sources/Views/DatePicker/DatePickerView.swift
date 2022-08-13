import Foundation
import UIKit

public final class DatePickerView: UIDatePicker, IComponent {
	
	private var props: DatePicker? = nil
	
	required init() {
		super.init(frame: .zero)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func setup() {
		self.addTarget(
			self,
			action: #selector(valueChanged),
			for: .valueChanged
		)
		
		if #available(iOS 13.4, *) {
			self.preferredDatePickerStyle = .wheels
		}
	}
	
	public func render(props: DatePicker) {
		if props == self.props { return }
		
		defer { self.props = props }
		
		if let date = props.date {
			self.setDate(date, animated: false)
		}
		
		self.datePickerMode = props.mode
		self.minimumDate = props.minimumDate
		self.maximumDate = props.maximumDate
	}
	
	@objc
	func valueChanged() {
		self.props?.onValueChange.perform(with: self.date)
	}
}
