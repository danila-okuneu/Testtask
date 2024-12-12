//
//  UsersView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol UsersViewProtocol: AnyObject {
	
	var presenter: UsersPresenterProtocol? { get set }
}

protocol UsersViewInputs: AnyObject {
	
	// Define input methods
}

protocol UsersViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class UsersViewController: UIViewController, UsersViewProtocol {
	
	var presenter: UsersPresenterProtocol?
	
}

// MARK: - Input & Output
extension UsersViewController: UsersViewInputs, UsersViewOutputs {
	
	// Extend functionality
}

