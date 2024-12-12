//
//  NavigationView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol NavigationViewProtocol: AnyObject {
	
	var presenter: NavigationPresenterProtocol? { get set }
}

protocol NavigationViewInputs: AnyObject {
	
	// Define input methods
}

protocol NavigationViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class NavigationViewController: UIViewController, NavigationViewProtocol {
	
	var presenter: NavigationPresenterProtocol?
	
}

// MARK: - Input & Output
extension NavigationViewController: NavigationViewInputs, NavigationViewOutputs {
	
	// Extend functionality
}

