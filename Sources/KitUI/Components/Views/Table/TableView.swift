import Foundation
import UIKit

/// Вью для компонента Table
public final class TableView: UITableView, IComponent {
	
	// MARK: - Private properties
	
	private var props: Table = .initial
	
	private var cellIdentifiers: [ObjectIdentifier: String] = [:]
	private var headerFooterIdentifiers: [ObjectIdentifier: String] = [:]
	
	private var frozenContentOffsetForRowAnimation: CGPoint?
	
	// MARK: - Lifecycle
	
	init() {
		super.init(frame: .zero, style: .grouped)
		setup()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		size
	}
	
	// MARK: - Public methods
	
	public func render(props: Table) {
		self.separatorStyle = props.separator
		self.bounces = props.bounces
		setEditing(props.isEditing, animated: true)
		guard self.props.changeID != props.changeID else {
			self.props = props
			return
		}
		
		self.props = props
		
		switch props.changeID.type {
		case .reload:
			reloadData()
		case .update(let indexPaths):
			updateCells(at: indexPaths)
		case .updateVisible:
			
			let visCells = visibleCells
			let count = visCells.count
			let some = count + 1
			
			updateCells(at: indexPathsForVisibleRows ?? [])
			let visibleSections = indexesOfVisibleSections
			updateSectionHeader(at: visibleSections)
			updateSectionFooter(at: visibleSections)

			let originalContentOffset = contentOffset

			beginUpdates()
			endUpdates()

			if contentOffset != originalContentOffset {
				frozenContentOffsetForRowAnimation = contentOffset
			}
		}
	}
	
	// MARK: - Private methods
	
	private func setup() {
		keyboardDismissMode = .interactive
		rowHeight = UITableView.automaticDimension
		estimatedRowHeight = UITableView.automaticDimension
		sectionHeaderHeight = UITableView.automaticDimension
		estimatedSectionHeaderHeight = UITableView.automaticDimension
		
		sectionFooterHeight = UITableView.automaticDimension
		estimatedSectionFooterHeight = UITableView.automaticDimension
		
		allowsSelection = false
		allowsSelectionDuringEditing = false
		
		backgroundView = nil
		backgroundColor = .clear
		
		delegate = self
		dataSource = self
		
		let notificationCenter = NotificationCenter.default
		
		notificationCenter.addObserver(
			self,
			selector: #selector(adjustForKeyboard),
			name: UIResponder.keyboardWillHideNotification,
			object: nil
		)
		notificationCenter.addObserver(
			self,
			selector: #selector(adjustForKeyboard),
			name: UIResponder.keyboardWillChangeFrameNotification,
			object: nil
		)
	}
	
	@objc
	func adjustForKeyboard(notification: Notification) {
		guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
		
		let keyboardScreenEndFrame = keyboardValue.cgRectValue
		let keyboardViewEndFrame = convert(keyboardScreenEndFrame, from: window)
		let keyboardHeight: CGFloat
		if notification.name == UIResponder.keyboardWillHideNotification {
			keyboardHeight = 0
		} else {
			keyboardHeight = keyboardViewEndFrame.height
		}
		
		guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber else { return }
		
		UIView.animate(withDuration: keyboardAnimationDuration.doubleValue) {
			self.contentInset = UIEdgeInsets(
				top: self.contentInset.top,
				left: self.contentInset.left,
				bottom: keyboardHeight,
				right: self.contentInset.right
			)
		}
	}
	
	private func updateCells(at indexPaths: [IndexPath]) {
		indexPaths.forEach { indexPath in
			if
				let cell = cellForRow(at: indexPath) as? ITableCellView,
				let item = props.cellAtIndexPath(indexPath)
			{
				item.update(cell.customContentView)
			}
		}
	}
	
	private func updateSectionHeader(at indexes: [Int]) {
		indexes.forEach { index in
			if
				let section = headerView(forSection: index) as? ITableHeaderFooterView,
				let item = props.headerAtSection?(index)
			{
				item.update(section.customContentView)
			}
		}
	}
	
	private func updateSectionFooter(at indexes: [Int]) {
		indexes.forEach { index in
			if
				let section = footerView(forSection: index) as? ITableHeaderFooterView,
				let item = props.footerAtSection?(index)
			{
				item.update(section.customContentView)
			}
		}
	}
}

// MARK: - UITableViewDelegate

extension TableView: UITableViewDelegate {
	public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
		return .none
	}
	
	public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
		return false
	}
	
	public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		frozenContentOffsetForRowAnimation = nil
	}
	
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if let overrideOffset = frozenContentOffsetForRowAnimation, scrollView.contentOffset != overrideOffset {
			scrollView.setContentOffset(overrideOffset, animated: false)
		}
	}
}

// MARK: - UITableViewDataSource

extension TableView: UITableViewDataSource {
	public func numberOfSections(in tableView: UITableView) -> Int {
		props.numberOfSections
	}
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		props.numberOfRowsInSection(section) ?? 0
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let item = props.cellAtIndexPath(indexPath)
		else { fatalError("No cell found") }
		
		let cellType = item.tableCellViewType
		
		let classIdentifier = ObjectIdentifier(cellType)
		let cellIdentifier: String
		
		if let storedCellIdentifier = cellIdentifiers[classIdentifier] {
			cellIdentifier = storedCellIdentifier
		} else {
			let newCellIdentifier = String(describing: cellType)
			register(cellType, forCellReuseIdentifier: newCellIdentifier)
			cellIdentifiers[classIdentifier] = newCellIdentifier
			cellIdentifier = newCellIdentifier
		}
		
		let cell = dequeueReusableCell(cellType: cellType, identifier: cellIdentifier)
		
		if indexPath.row != .zero {
			cell.margins.top += props.spacing
		}
		
		item.update(cell.customContentView)
		
		return cell
	}
	
	public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		guard
			let item = props.headerAtSection?(section)
		else { return nil }
		
		return headerFooterView(with: item)
	}
	
	public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if props.headerAtSection?(section) != nil {
			return UITableView.automaticDimension
		}
		return .zero
	}
	
	public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		guard
			let item = props.footerAtSection?(section)
		else { return nil }
		
		return headerFooterView(with: item)
	}
	
	public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		if props.footerAtSection?(section) != nil {
			return UITableView.automaticDimension
		}
		return .zero
	}
	
	// MARK: - Private methods
	
	private func dequeueReusableCell<TCell: UITableViewCell>(cellType: TCell.Type, identifier: String) -> ITableCellView {
		guard let cell = dequeueReusableCell(withIdentifier: identifier) as? ITableCellView else {
			fatalError("No cell found")
		}
		return cell
	}
	
	private func headerFooterView(with item: MetaView) -> UITableViewHeaderFooterView {
		let viewType = item.headerFooterViewType
		
		let classIdentifier = ObjectIdentifier(viewType)
		let headerFooterIdentifier: String
		
		if let storedIdentifier = headerFooterIdentifiers[classIdentifier] {
			headerFooterIdentifier = storedIdentifier
		} else {
			let newHeaderFooterIdentifier = String(describing: viewType)
			register(viewType, forHeaderFooterViewReuseIdentifier: newHeaderFooterIdentifier)
			headerFooterIdentifiers[classIdentifier] = newHeaderFooterIdentifier
			headerFooterIdentifier = newHeaderFooterIdentifier
		}
		
		let headerFooter = dequeueReusableHeaderFooterView(headerFooterType: viewType, identifier: headerFooterIdentifier)
		
		item.update(headerFooter.customContentView)
		
		return headerFooter
	}
	
	private func dequeueReusableHeaderFooterView<THeaderFooter: UITableViewHeaderFooterView>(
		headerFooterType: THeaderFooter.Type,
		identifier: String
	) -> ITableHeaderFooterView {
		guard let view = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? ITableHeaderFooterView else {
			fatalError("No cell found")
		}
		return view
	}
	
	public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
		if let canMove = props.canMoveCell?(indexPath) {
			return canMove
		}
		return false
	}
	
	public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
		if let newDestination = props.proposedIndexPathOnMoveFromTo?(sourceIndexPath, proposedDestinationIndexPath) {
			return newDestination
		}
		return proposedDestinationIndexPath
	}
	
	public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		props.onReorder?.perform(with: (from: sourceIndexPath, to: destinationIndexPath))
	}
}

extension TableView: UITableViewDragDelegate {
	public func tableView(_ table: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
		guard tableView(table, canMoveRowAt: indexPath) == true else { return [] }
		let dragItem = UIDragItem(itemProvider: NSItemProvider())
		dragItem.localObject = props.cellAtIndexPath(indexPath)
		return [ dragItem ]
	}
}
