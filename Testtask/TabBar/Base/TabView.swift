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
	
	func setupTabBar()
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage?
	)
}

// MARK: - View
final class TabViewController: UITabBarController, TabViewProtocol {
	
	var presenter: TabPresenter?
	
	
	
	init() {
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		presenter?.viewWillAppear()
	}
}

// MARK: - Input
extension TabViewController: TabViewInputs {
	
	
	func setupTabBar() {
		
		
		view.backgroundColor = .white
		tabBar.backgroundImage = UIImage()
		tabBar.shadowImage = UIImage()
		
		tabBar.tintColor = .appCyan
		tabBar.isTranslucent = false
		tabBar.backgroundColor = .tabBarBackground
		tabBar.barTintColor = .tabBarBackground
	}
	
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage? = nil
	) {
		viewController.tabBarItem.title = title
		viewController.tabBarItem.image = image
		viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: C.Font.bodySmall], for: .normal)
		
		
		if let vcs = viewControllers {
			viewControllers = vcs + [viewController]
		} else {
			viewControllers = [viewController]
		}
	}
	
}
