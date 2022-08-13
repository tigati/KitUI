import Foundation

extension MetaView {
	public static func datePicker(
		date: Date?,
		from: Date?,
		to: Date?,
		onValueChange: ViewCommandWith<Date>
	) -> MetaView {
		let props = DatePicker(
			mode: .date,
			date: date,
			minimumDate: from,
			maximumDate: to,
			onValueChange: onValueChange
		)
		return .init(props: props)
	}
}
