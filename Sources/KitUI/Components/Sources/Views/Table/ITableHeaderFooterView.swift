//
//  ITableHeaderView.swift
//  DrivenUI
//
//  Created by Gayfulin Timur Farkhatovich on 20.11.2021.
//

import Foundation
import UIKit

// Протокол для доступа к customContentView и margins
protocol ITableHeaderFooterView: UITableViewHeaderFooterView {

	var customContentView: UIView { get }

	var margins: UIEdgeInsets { get set }
}
