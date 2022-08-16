import Foundation

extension MetaVC {
	
	/// Компонент Navigation
	/// - Parameters:
	///  - stack: Стек из `MetaVC` для отображения
	///  - onPop: Реакция при возврате назад (по кнопке назад или жесту)
	public static func navigation(
		stack: [MetaVC],
		onPop: ViewCommandWith<Int>,
		progress: Float? = nil
	) -> MetaVC {
		.init(
			props: Navigation(
				stack: stack,
				onPop: onPop,
				progress: progress
			)
		)
	}
	
	public static let nilNavigation = MetaVC.init(props: Optional<Navigation>.none)
}
