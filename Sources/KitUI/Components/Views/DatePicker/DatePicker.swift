import Foundation
import UIKit

public struct DatePicker: IViewProps, Equatable {
	public static let type: String = String(reflecting: Self.self)
	public typealias View = DatePickerView
	
	public let mode: UIDatePicker.Mode
	public let date: Date?
	public let minimumDate: Date?
	public let maximumDate: Date?
	
	public let onValueChange: ViewCommandWith<Date>
	
	
	public func makeView(viewType: DatePickerView.Type) -> DatePickerView {
		DatePickerView()
	}
	
	public func updateView(_ view: DatePickerView) {
		view.render(props: self)
	}
}
