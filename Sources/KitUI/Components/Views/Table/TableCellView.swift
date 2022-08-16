//
//  UICollectionView+SectionDiff.swift
//  Shipment
//
//  Created by Gayfulin Timur Farkhatovich on 22.09.2021.
//  Copyright © 2021 Sportmaster. All rights reserved.
//

import UIKit

/// Общая ячейка-контейнер
public final class TableCellView<TContentView: UIView>: UITableViewCell, ITableCellView {

	// MARK: - Internal properties

	let customContentView: UIView = TContentView()
	var margins: UIEdgeInsets = .zero

	// MARK: - Lifecycle

	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	public override func layoutSubviews() {
		super.layoutSubviews()
		layout()
	}

	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		let innerSize = size.inset(by: margins)
		return customContentView.sizeThatFits(innerSize).offset(by: margins)
	}

	// MARK: - Private methods

	private func setup() {
		backgroundView = nil
		backgroundColor = .clear
		contentView.addSubview(customContentView)
	}

	private func layout() {
		customContentView.pin.all(margins).sizeToFit(.width)
	}
}
