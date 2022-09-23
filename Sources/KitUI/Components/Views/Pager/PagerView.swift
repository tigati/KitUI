import Foundation
import UIKit

public final class PagerView: ComponentView, IComponent {
	
	private var props: Pager = .initial
	
	private var cellIdentifiers: [ObjectIdentifier: String] = [:]
	
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		let collectionView = UICollectionView(
			frame: .zero,
			collectionViewLayout: layout
		)
		collectionView.showsHorizontalScrollIndicator = false
		collectionView.isPagingEnabled = true
		collectionView.delegate = self
		collectionView.dataSource = self
		return collectionView
	}()
	
	public override func setup() {
		collectionView.backgroundView = nil
		collectionView.backgroundColor = .clear
		collectionView.contentInsetAdjustmentBehavior = .never
		addSubview(collectionView)
	}
	
	public var didInitialMove: Bool = false
	
	public override func layout() {
		collectionView.pin.all()
		
		if didInitialMove == false {
			moveToPage(at: props.currentPage)
			didInitialMove = true
		}
	}
	
	public func render(props: Pager) {
		let oldProps = self.props
		
		guard self.props.changeID != props.changeID else {
			self.props = props
			return
		}
		
		switch props.changeID.type {
		case .reload:
			self.props = props
			collectionView.reloadData()
		case .updateVisible:
			self.props = props
			updateVisibleCells()
		}
		
		if oldProps.currentPage != props.currentPage {
			moveToPage(at: props.currentPage)
		}
		setNeedsLayout()
	}
	
	private func moveToPage(at index: Int) {
		self.collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: false)
	}
	
	private func updateVisibleCells() {
		let visibleItems = collectionView.indexPathsForVisibleItems
		visibleItems.forEach { indexPath in
			guard
				let cell = collectionView.cellForItem(at: indexPath) as? ICollectionCellView
			else { return }
			let item = props.pageAtIndex(indexPath.row)
			item.update(cell.customContentView)
		}
	}
	
	private func dequeueReusableCell<TCell: UICollectionViewCell>(
		cellType: TCell.Type,
		identifier: String,
		indexPath: IndexPath
	) -> ICollectionCellView {
		guard let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: identifier,
			for: indexPath) as? ICollectionCellView else
		{
			fatalError("No cell found")
		}
		return cell
	}
}

extension PagerView: UICollectionViewDelegateFlowLayout {
	public func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let page = (scrollView.contentOffset.x / scrollView.bounds.size.width)
		props.onPageScroll.perform(with: page)
	}
	
	public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
		let page = Int(self.collectionView.contentOffset.x / self.collectionView.frame.size.width)
		endEditing(true)
		props.onPageBecameCurrent.perform(with: page)
	}
	
	public func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		sizeForItemAt indexPath: IndexPath
	) -> CGSize {
		return CGSize(
			width: collectionView.frame.width,
			height: collectionView.frame.height - collectionView.adjustedContentInset.top - collectionView.adjustedContentInset.bottom
		)
	}
	
	public func collectionView(
		_ collectionView: UICollectionView,
		layout collectionViewLayout: UICollectionViewLayout,
		minimumLineSpacingForSectionAt section: Int
	) -> CGFloat {
		return 0
	}
	
	public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return .zero
	}
}

extension PagerView: UICollectionViewDataSource {
	public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		props.numberOfPages
	}
	
	public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let item = props.pageAtIndex(indexPath.row)
		let cellType = item.collectionCellViewType
		
		let classIdentifier = ObjectIdentifier(cellType)
		let cellIdentifier: String
		
		if let storedCellIdentifier = cellIdentifiers[classIdentifier] {
			cellIdentifier = storedCellIdentifier
		} else {
			let newCellIdentifier = String(describing: cellType)
			collectionView.register(cellType, forCellWithReuseIdentifier: newCellIdentifier)
			cellIdentifiers[classIdentifier] = newCellIdentifier
			cellIdentifier = newCellIdentifier
		}
		
		let cell = self.dequeueReusableCell(
			cellType: cellType,
			identifier: cellIdentifier,
			indexPath: indexPath
		)
		
		item.update(cell.customContentView)
		
		return cell
	}
}
