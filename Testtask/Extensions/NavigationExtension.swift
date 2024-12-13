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
	
	
}
