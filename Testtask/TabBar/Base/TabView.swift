//
//  TabView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol TabViewProtocol: AnyObject {
	
	var presenter: TabPresenterProtocol? { get set }
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
	
	var presenter: TabPresenterProtocol?
	
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		print(presenter)
		presenter?.viewWillAppear()
	}
	
}

// MARK: - Input & Output
extension TabViewController: TabViewInputs, TabViewOutputs {
	
	func addTab(
		_ viewController: UIViewController,
		title: String,
		image: UIImage?,
		selectedImage: UIImage? = nil
	) {
	
		viewController.tabBarItem.title = title
		viewController.tabBarItem.image = image
		viewController.tabBarItem.selectedImage = selectedImage
		
		
		print("added")
		if let viewControllers {
			
			self.viewControllers?.append(viewController)
			 
		} else {
			viewControllers = [viewController]
		}
	}
	
	// Extend functionality
}

