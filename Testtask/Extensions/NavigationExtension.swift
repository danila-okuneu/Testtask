//
//  NavigationExtension.swift
//  Testtask
//
//  Created by Danila Okuneu on 14.12.24.
//

import UIKit

extension UIViewController {
	
	func navigated() -> UINavigationController {
		StateNavigationController(rootViewController: self)
	}
	
	
	
}

final class StateNavigationController: UINavigationController {
	
	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		
		
		let appearance = UINavigationBarAppearance()
		appearance.configureWithOpaqueBackground()
		appearance.backgroundColor = .clear
		appearance.titleTextAttributes = [
			NSAttributedString.Key.font: C.Font.heading,
			NSAttributedString.Key.foregroundColor: UIColor.primaryText
		]
		
		navigationBar.standardAppearance = appearance
		navigationBar.scrollEdgeAppearance = appearance
		navigationBar.compactAppearance = appearance
		
		navigationBar.barTintColor = .accent
		navigationBar.backgroundColor = .accent
		guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
		guard let statusBarManager = scene.statusBarManager else { return }
		
		let view = UIView(frame: statusBarManager.statusBarFrame)
		navigationBar.addSubview(view)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	
}
