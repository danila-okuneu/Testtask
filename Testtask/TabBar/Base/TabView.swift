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
	
	// Define input methods
}

protocol TabViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class TabViewController: UITabBarController, TabViewProtocol {
	
	var presenter: TabPresenterProtocol?
	
}

// MARK: - Input & Output
extension TabViewController: TabViewInputs, TabViewOutputs {
	
	// Extend functionality
}

