//
//  ConnectionView.swift
//  Testtask
//
//  Created by Danila Okuneu on 12.12.24.
//

import UIKit
import SnapKit

protocol ConnectionViewProtocol: AnyObject {
	
	var presenter: ConnectionPresenterProtocol? { get set }
}

protocol ConnectionViewInputs: AnyObject {
	
	// Define input methods
}

protocol ConnectionViewOutputs: AnyObject {
	
	// Define output methods
}

// MARK: - View
final class ConnectionViewController: UIViewController, ConnectionViewProtocol {
	
	var presenter: ConnectionPresenterProtocol?
	
}

// MARK: - Input & Output
extension ConnectionViewController: ConnectionViewInputs, ConnectionViewOutputs {
	
	// Extend functionality
}

