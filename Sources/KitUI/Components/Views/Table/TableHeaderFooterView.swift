//
//  TableHeaderView.swift
//  DrivenUI
//
//  Created by Gayfulin Timur Farkhatovich on 20.11.2021.
//

import Foundation
import UIKit

/// Общая ячейка-контейнер
public final class TableHeaderFooterView<TContentView: UIView>: UITableViewHeaderFooterView, ITableHeaderFooterView {

	// MARK: - Internal properties

	let customContentView: UIView = TContentView()
	var margins: UIEdgeInsets = .zero

	// MARK: - Lifecycle

	public override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
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
		contentView.addSubview(customContentView)
	}

	private func layout() {
		tintColor = .clear
		backgroundView?.backgroundColor = .clear
		contentView.backgroundColor = .clear
		customContentView.pin.all(margins).sizeToFit(.width)
	}
}
