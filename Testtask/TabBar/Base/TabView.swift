//
//  TabView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol TabViewProtocol: AnyObject {
	
	var presenter: TabPresenter? { get set }
}

protocol TabViewInputs: AnyObject {
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage?
	)
}

protocol TabViewOutputs: AnyObject {

	// Define output methods
}

// MARK: - View
final class TabViewController: UITabBarController, TabViewProtocol {
	
	var presenter: TabPresenter?



	init() {
		super.init(nibName: nil, bundle: nil)
		
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
		
		tabBar.tintColor = .appCyan
		tabBar.isTranslucent = false
		tabBar.backgroundColor = .tabBarBackground
		tabBar.barTintColor = .tabBarBackground
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}	
}

// MARK: - Input & Output
extension TabViewController: TabViewInputs {
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage? = nil
	) {
		
		
		viewController.tabBarItem.title = title
		viewController.tabBarItem.image = image
		viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.nunitoSans(ofSize: 14)], for: .normal)
		
		
		if let vcs = viewControllers {
			viewControllers = vcs + [viewController]
		} else {
			viewControllers = [viewController]
		}
		
	
	}
	
}
