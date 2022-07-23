import Foundation
import UIKit

extension StackView {

	// Вспомогательный класс для работы стека
	class Components {
		let views: [UIView]
		var sizes: [Size]
		var cgSizes: [CGSize]
		let axis: Axis
		let spacing: CGFloat
		var sortedByLayoutPriority: [[ViewData]]

		init(
			props: Stack,
			views: [UIView]
		) {
			self.axis = props.axis
			self.views = views
			self.sizes = Array(repeating: Size.zero, count: views.count)
			self.cgSizes = Array(repeating: CGSize.zero, count: views.count)
			self.spacing = props.spacing

			var dictionary: [Int: [ViewData]] = [:]

			for (index, meta) in props.items.enumerated() {

				let viewData = ViewData(
					index: index
				)

				if dictionary[meta.layoutPriority] == nil {
					dictionary[meta.layoutPriority] = []
				}

				dictionary[meta.layoutPriority]?.append(viewData)
			}

			let sortedMeta = dictionary.sorted { lhs, rhs in
				lhs.key > rhs.key
			}
				.map { $0.value }

			self.sortedByLayoutPriority = sortedMeta
		}

		func calculateSizes(sizeToFit: CGSize) {
			let size = sizeToFit.map(for: axis)
			var availableAlongLength = size.alongLength
			let availableCrossLength = size.crossLength

			let overallSpacing = spacing * CGFloat(views.count - 1)

			availableAlongLength -= overallSpacing

			for (index, viewDatas) in sortedByLayoutPriority.enumerated() {
				if availableAlongLength <= 0 {
					availableAlongLength = 0
				}

				let items = Array(viewDatas.indices)

				availableAlongLength = calculateSizes(
					level: index,
					items: items,
					size: .init(
						alongLength: availableAlongLength,
						crossLength: availableCrossLength
					)
				)
			}
		}

		func combinedSize() -> CGSize {
			let overallSpacing = spacing * CGFloat(views.count - 1)

			let initial = Size(
				alongLength: overallSpacing,
				crossLength: .zero
			)
			let result = sizes.reduce(initial) { partialResult, nextSize in
				Size(
					alongLength: partialResult.alongLength + nextSize.alongLength,
					crossLength: max(partialResult.crossLength, nextSize.crossLength)
				)
			}
			return result.map(for: axis)
		}

		private func calculateSizes(
			level: Int,
			items: [Int],
			size: Size
		) -> CGFloat {
			var availableAlongLength = size.alongLength
			let availableCrossLength = size.crossLength

			let componentAvailableAlongLength = availableAlongLength / CGFloat(items.count)

			let viewDatas = sortedByLayoutPriority[level]

			for index in items {
				let viewData = viewDatas[index]
				let component = views[viewData.index]

				let size = Size(
					alongLength: componentAvailableAlongLength,
					crossLength: availableCrossLength
				)

				let sizeToFit = size.map(for: axis)

				let uiSize = component.sizeThatFits(sizeToFit)

				let limitedUISize = uiSize.limitNotNil(with: sizeToFit)
				let limitedCalculatedSize = limitedUISize.map(for: axis)

				sizes[viewData.index] = limitedCalculatedSize
				cgSizes[viewData.index] = limitedUISize

				availableAlongLength -= limitedCalculatedSize.alongLength
			}

			if availableAlongLength <= .zero {
				availableAlongLength = .zero
				return .zero
			}

			if items.count == 1 {
				return availableAlongLength
			}

			for index in items {
				let viewData = viewDatas[index]
				let component = views[viewData.index]
				let previousSize = sizes[viewData.index]

				let newSize = Size(
					alongLength: previousSize.alongLength + availableAlongLength,
					crossLength: availableCrossLength
				)

				let sizeToFit = newSize.map(for: axis)

				let uiSize = component.sizeThatFits(sizeToFit)
				let calculatedSize = uiSize.map(for: axis)

				let limitedUISize = uiSize.limitNotNil(with: sizeToFit)
				let limitedCalculatedSize = limitedUISize.map(for: axis)

				sizes[viewData.index] = limitedCalculatedSize
				cgSizes[viewData.index] = limitedUISize

				availableAlongLength -= (calculatedSize.alongLength - previousSize.alongLength)

				if availableAlongLength <= .zero {
					availableAlongLength = .zero
				}
			}

			return availableAlongLength
		}
	}

	struct ViewData {
		// индекс компонента в массиве вью
		var index: Int
	}

	// относительный размер
	struct Size {
		// размер вдоль продольной линии стека
		let alongLength: CGFloat
		// размер поперёк продольной линии стека
		let crossLength: CGFloat

		static let zero = Self(
			alongLength: .zero,
			crossLength: .zero
		)

		// преобразование размера
		func map(for axis: Axis) -> CGSize {
			switch axis {
			case .horizontal:
				return CGSize(
					width: alongLength,
					height: crossLength
				)
			case .vertical:
				return CGSize(
					width: crossLength,
					height: alongLength
				)
			}
		}
	}
}

// MARK: CGSize+map

extension CGSize {
	// преобразование размера
	func map(for axis: Axis) -> Stack.View.Size {
		switch axis {
		case .horizontal:
			return .init(
				alongLength: width,
				crossLength: height
			)
		case .vertical:
			return .init(
				alongLength: height,
				crossLength: width
			)
		}
	}
}

fileprivate extension CGSize {
	func limitNotNil(with size: CGSize) -> CGSize {
		return CGSize(
			width: size.width > 0 ? min(width, size.width) : width,
			height: size.height > 0 ? min(height, size.height): height
		)
	}
}
