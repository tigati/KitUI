import Foundation
import UIKit
import DifferenceKit

public final class NavigationViewController: UINavigationController, IComponent {
	
	// MARK: - Private properties
	
	private var _viewID: String = ""
	
	private var props: Navigation = .initial
	
	private var pendingProps: Navigation?
	
	private var progressView: UIProgressView?

	// MARK: - Lifecycle
	
	public init() {
		super.init(nibName: nil, bundle: nil)
		delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Public methods
	
	public override func setViewID(_ viewID: String) {
		_viewID = viewID
	}
	
	public override func getViewID() -> String {
		_viewID
	}
	
	public func render(props: Navigation) {
		defer { self.props = props }
		let oldStack = self.props.stack
		let newStack = props.stack
		
		let propsIDs = oldStack.map { $0.id }
		let viewIDs = viewControllers.map { $0.getViewID() }
		
		let oldStagedChangeset = StagedChangeset(source: propsIDs, target: viewIDs)
		
		if !oldStagedChangeset.isEmpty {
			return
		}
		
		let stagedChangeset = StagedChangeset(source: oldStack, target: newStack)
		
		var newViewControllers: [UIViewController] = viewControllers
		
		for changeset in stagedChangeset {
			for delete in changeset.elementDeleted {
				newViewControllers.remove(at: delete.element)
			}
			
			for insert in changeset.elementInserted {
				let newVC = newStack[insert.element]
				let newViewController = newVC.makeView()
				newVC.update(newViewController)
				newViewControllers.insert(newViewController, at: insert.element)
			}
			
			for update in changeset.elementUpdated {
				let viewController = newViewControllers[update.element]
				newStack[update.element].update(viewController)
			}
			
			for (source, target) in changeset.elementMoved {
				newViewControllers.swapAt(source.element, target.element)
			}
		}
		
		setViewControllers(newViewControllers, animated: true)
		
		setProgress(props.progress)
	}
	
	private func setProgress(_ progress: Float?) {
		if let progress = progress {
			if progressView == nil {
				let newProgressView = UIProgressView(progressViewStyle: .default)
				view.addSubview(newProgressView)
				let navBar = navigationBar
				
				newProgressView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor).isActive = true
				newProgressView.centerXAnchor.constraint(equalTo: navBar.centerXAnchor).isActive = true
				newProgressView.widthAnchor.constraint(equalTo: navBar.widthAnchor, multiplier: 0.43).isActive = true
				
				newProgressView.translatesAutoresizingMaskIntoConstraints = false
				newProgressView.setProgress(0.0, animated: false)
				newProgressView.tintColor = .red
				progressView = newProgressView
			}
			
			progressView?.setProgress(progress, animated: true)
		} else {
			progressView?.removeFromSuperview()
			progressView = nil
		}
	}
}

// MARK: - UINavigationControllerDelegate

extension NavigationViewController: UINavigationControllerDelegate {
	
	public func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		guard
			let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from),
			navigationController.viewControllers.contains(fromViewController) == false
		else { return }
		
		let newStack = zip(viewControllers, props.stack).map { $0.1 }
		
		let diff = props.stack.count - newStack.count
		
		guard diff > 0 else {
			return
		}
		
		let newProps = Props(
			stack: newStack,
			onPop: props.onPop,
			progress: props.progress
		)
		
		self.props = newProps
		
		props.onPop.perform(with: diff)
		
		if let pendingProps = self.pendingProps {
			render(props: pendingProps)
		}
	}
}
